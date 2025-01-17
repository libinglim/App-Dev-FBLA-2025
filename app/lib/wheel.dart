import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';
import 'dart:async';
import 'package:confetti/confetti.dart';
import 'globals.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  final StreamController<int> selected = StreamController<int>();
  late ConfettiController confettiController;
  bool isBackButtonHovered = false;
  bool spinning = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    for (int i = 0; i < Globals.availableItems.length; i++) {
      if (Globals.accessories.contains(Globals.availableItems[i])) {
        Globals.availableItems.removeAt(i);
      }
    }
    if (Globals.availableItems.isEmpty) {
      Globals.availableItems = [
        'images/ScarfNeck.png',
        'images/SantaHat.png',
        'images/MonocleHead.png',
        'images/RadGlassesHead.png',
        'images/BeanieHat.png',
        'images/TopHat.png',
      ];
    }
  }

  @override
  void dispose() {
    selected.close();
    confettiController.dispose();
    super.dispose();
  }

  void spinWheel() {
    if (Globals.spins > 0 && Globals.availableItems.isNotEmpty) {
      setState(() {
        Globals.spins--;
        spinning = true;
      });

      final random = Random();
      selectedIndex = random.nextInt(Globals.availableItems.length);
      selected.add(selectedIndex);

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          final wonItem = Globals.availableItems[selectedIndex];
          Globals.accessories.add(wonItem);
          Globals.availableItems.removeAt(selectedIndex);

          confettiController.play();

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🎉 Congratulations! 🎉\nYou Won:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Image.asset(
                      wonItem,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        confettiController.stop();
                        Navigator.of(context).pop();
                        setState(() {
                          spinning = false;
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    isBackButtonHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    isBackButtonHovered = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBackButtonHovered
                          ? Colors.blueAccent
                          : Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: isBackButtonHovered
                          ? Colors.white
                          : Colors.blueAccent,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Spin to Win!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Colors.yellow,
                    Colors.orange,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: FractionallySizedBox(
                      child: FortuneWheel(
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          for (int i = 0;
                              i < Globals.availableItems.length;
                              i++)
                            FortuneItem(
                              child: Image.asset(
                                Globals.availableItems[i],
                                fit: BoxFit.contain,
                                height: 50,
                                width: 50,
                              ),
                              style: FortuneItemStyle(
                                color: i.isEven ? Colors.green : Colors.amber,
                                borderColor: Colors.white,
                                borderWidth: 3,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed:
                      Globals.spins > 0 && Globals.availableItems.isNotEmpty
                          ? () {
                              if (!spinning) {
                                spinWheel();
                              }
                            }
                          : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor:
                        Globals.spins > 0 ? Colors.orange : Colors.grey,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(Globals.spins > 0
                      ? 'Spin the Wheel (${Globals.spins} left)'
                      : 'No Spins Left'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
