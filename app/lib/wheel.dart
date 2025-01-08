import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';
import 'dart:async';
import 'package:confetti/confetti.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  final List<String> items = [
    'Prize 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5',
    'Prize 6',
  ];

  final StreamController<int> selected = StreamController<int>();
  late ConfettiController confettiController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    selected.close();
    confettiController.dispose();
    super.dispose();
  }

  void spinWheel() {
    final random = Random();
    selectedIndex = random.nextInt(items.length);
    selected.add(selectedIndex);

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        confettiController.play();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Congratulations!'),
            content: Text('You won: ${items[selectedIndex]}'),
            actions: [
              TextButton(
                onPressed: () {
                  confettiController.stop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortune Wheel'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0; i < items.length; i++)
                      FortuneItem(
                        child: Text(
                          items[i],
                          style: const TextStyle(
                            color: Colors.white, // Text color for readability
                          ),
                        ),
                        style: FortuneItemStyle(
                          color: i.isEven
                              ? Colors.green
                              : Colors.amber, // Alternate green and gold
                          borderColor: Colors.white,
                          borderWidth: 3,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: spinWheel,
                child: const Text('Spin the Wheel'),
              ),
              const SizedBox(height: 20),
              /*ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Questions()),
                  );
                },
                child: const Text('Go to Page'),
              )*/
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
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
        ],
      ),
    );
  }
}
