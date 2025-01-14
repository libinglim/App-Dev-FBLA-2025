import 'package:flutter/material.dart';
import 'dart:math';
import 'globals.dart';
import 'homePage.dart'; // Import the HomePage

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final Random _random = Random();
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  late String _question;
  late int _correctOption;
  List<int> _options = [];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    int num1 = _random.nextInt(20) + 1;
    int num2 = _random.nextInt(20) + 1;
    _correctOption = num1 + num2;
    _question = '$num1 + $num2 = ?';
    _options = _generateOptions(_correctOption);
  }

  List<int> _generateOptions(int correct) {
    List<int> options = [correct];
    while (options.length < 4) {
      int option = _random.nextInt(40) + 1;
      if (!options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();
    return options;
  }

  void _checkAnswer(int selectedOption) {
    if (selectedOption == _correctOption) {
      _correctAnswers++;
      Globals.coins += 100;
      if (_correctAnswers % 10 == 0) {
        Globals.spins++;
        _showMessage('Congratulations!', 'You earned +1 Spin!');
      } else {
        _showMessage('Correct!', 'You earned 100 coins!');
      }
    } else {
      _showMessage('Wrong!', 'The correct answer was $_correctOption.');
    }

    if (_currentQuestionIndex < 19) {
      setState(() {
        _currentQuestionIndex++;
        _generateQuestion();
      });
    } else {
      _showMessage(
        'Quiz Completed',
        'You answered $_correctAnswers out of 20 questions correctly.',
      );
    }
  }

  void _showMessage(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow[700] ?? Colors.yellow,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money,
                          color: Colors.green[700], size: 24),
                      const SizedBox(width: 5),
                      Text(
                        '${Globals.coins}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} of 20',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  _question,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () => _checkAnswer(_options[index]),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          backgroundColor: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          '${_options[index]}',
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Coins: ${Globals.coins} | spins: ${Globals.spins}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
