import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';
import 'dart:async';
import 'package:confetti/confetti.dart';

class WheelPage extends StatefulWidget {
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
  ];

  final StreamController<int> selected = StreamController<int>();
  late ConfettiController confettiController; // Ensure this is initialized
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 3)); // Proper initialization
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

    // Delay to allow the wheel animation to complete
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        // Play confetti
        confettiController.play();

        // Show alert dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You won: ${items[selectedIndex]}'),
            actions: [
              TextButton(
                onPressed: () {
                  confettiController.stop(); // Stop confetti on dialog close
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
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
        title: Text('Fortune Wheel'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FortuneWheel(
                  selected: selected.stream,
                  items: [
                    for (var item in items)
                      FortuneItem(
                        child: Text(item),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: spinWheel,
                child: Text('Spin the Wheel'),
              ),
              SizedBox(height: 20),
            ],
          ),
          // Confetti widget
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
