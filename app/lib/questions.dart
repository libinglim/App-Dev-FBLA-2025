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
  final Random random = Random();

  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int difficultyLevel = 1;
  late String question;
  late int correctOption;
  late List<int> options;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    int num1 = random.nextInt(20 * difficultyLevel) + 1;
    int num2 = random.nextInt(20 * difficultyLevel) + 1;
    correctOption = num1 + num2;
    question = '$num1 + $num2 = ?';
    options = generateOptions(correctOption);
  }

  List<int> generateOptions(int correct) {
    List<int> options = [correct];
    while (options.length < 4) {
      int option = random.nextInt(40 * difficultyLevel) + 1;
      if (!options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();
    return options;
  }

  void checkAnswer(int selectedOption) {
    if (selectedOption == correctOption) {
      correctAnswers++;
      Globals.coins += 100;

      if (correctAnswers % 5 == 0) {
        Globals.spins++;
        showMessage(
            'Congratulations!', 'You earned +1 spin and advanced a level!');
        difficultyLevel++; // Increase difficulty every 5 correct answers
      } else {
        showMessage('Correct!', 'You earned 100 coins!');
      }
    } else {
      showMessage('Wrong!', 'The correct answer was $correctOption.');
    }

    if (currentQuestionIndex < 19) {
      setState(() {
        currentQuestionIndex++;
        generateQuestion();
      });
    } else {
      showMessage(
        'Quiz Completed',
        'You answered $correctAnswers out of 20 questions correctly.',
      );
    }
  }

  void showMessage(String title, String content) {
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
                // Progress Bar
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / 20,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 20),
                Text(
                  'Question ${currentQuestionIndex + 1} of 20',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  question,
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
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return AnimatedScale(
                        scale: 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(options[index]),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            backgroundColor: Colors.purpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            '${options[index]}',
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Coins: ${Globals.coins} | Spins: ${Globals.spins}',
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
