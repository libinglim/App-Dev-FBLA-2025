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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: StarryNightPainter(),
            ),
          ),
          // Back Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Progress Bar
          Positioned(
            top: 90,
            left: 20,
            right: 20,
            child: LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / 20,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation(Colors.purpleAccent),
            ),
          ),
// Money Display with Dollar Icon
          Positioned(
            top: 120,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.attach_money,
                    color: Colors.amberAccent,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${Globals.coins}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Question Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    question,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                // Answer Buttons
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
                      return ElevatedButton(
                        onPressed: () => checkAnswer(options[index]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          '${options[index]}',
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
