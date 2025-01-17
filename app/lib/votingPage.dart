import 'dart:async';

import 'package:app/robotCostumes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> with TickerProviderStateMixin {
  // Sample robot data (replace with real images/URLs if needed)
  final List<Map<String, dynamic>> robots = [
    {
      'name': 'Brady',
      'image': 'images/OvalRobot.png',
      'rating': 0,
      'hat': 'images/TopHat.png',
      'head': 'images/MonocleHead.png',
      'neck': 'images/MustacheNeck.png'
    },
    {
      'name': 'John',
      'image': 'images/robot.png',
      'rating': 0,
      'hat': 'images/BeanieHat.png',
      'head': '',
      'neck': ''
    },
    {
      'name': 'Evan',
      'image': 'images/RadRobot.png',
      'rating': 0,
      'hat': '',
      'head': 'images/RadGlassesHead.png',
      'neck': ''
    },
    {
      'name': 'Lily',
      'image': 'images/FemaleRobot.png',
      'rating': 0,
      'hat': '',
      'head': 'images/GlassesHead.png',
      'neck': 'images/ScarfNeck.png',
    },
    {
      'name': 'Mina',
      'image': 'images/WinkingRobot.png',
      'rating': 0,
      'hat': 'images/CowboyHat.png',
      'head': '',
      'neck': 'images/MustacheNeck.png',
    },
    {
      'name': 'Emma',
      'image': 'images/OvalRobot.png',
      'rating': 0,
      'hat': 'images/SantaHat.png',
      'head': '',
      'neck': 'images/BeardNeck.png',
    },
    {
      'name': 'Billy',
      'image': 'images/SquareRobot.png',
      'rating': 0,
      'hat': 'images/BucketHat.png',
      'head': 'images/MonocleHead.png',
      'neck': ''
    },
  ];
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  int _secondsRemaining = 30;
  bool votingEnded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    startCountdown();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        votingEnded = true;
        setState(() {});
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  void updateRating(int index, int rating) {
    setState(() {
      robots[index]['rating'] = rating;
    });
  }

  void goToPage(int index) {
    if (index >= 0 && index < robots.length) {
      setState(() {
        _currentPage = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: StagePainter(),
            ),
            if (_currentPage > 0 && !votingEnded)
              Positioned(
                left: 10,
                top: MediaQuery.of(context).size.height * 0.4,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 40, color: Colors.black54),
                  onPressed: () {
                    goToPage(_currentPage - 1);
                  },
                ),
              ),
            if (_currentPage < robots.length - 1 && !votingEnded)
              Positioned(
                right: 10,
                top: MediaQuery.of(context).size.height * 0.4,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      size: 40, color: Colors.black54),
                  onPressed: () {
                    goToPage(_currentPage + 1);
                  },
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 100),
                painter: CrowdPainter(),
              ),
            ),
            if (!votingEnded)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * (7 / 8),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: robots.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final robot = robots[index];
                      return RobotCard(
                        name: robot['name'],
                        imagePath: robot['image'],
                        currentRating: robot['rating'],
                        hat: robot['hat'],
                        head: robot['head'],
                        neck: robot['neck'],
                        onRatingSelected: (rating) =>
                            updateRating(index, rating),
                      );
                    },
                  ),
                ),
              ),
            if (votingEnded)
              Align(
                alignment: Alignment.topCenter,
                child: FadeTransition(
                  opacity: AnimationController(
                    vsync: this,
                    duration: const Duration(seconds: 1),
                  )..forward(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "🏆 Top Robots!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Second place
                          buildPodium(
                            robotName: robots[0]['name'],
                            imagePath: robots[0]['image'],
                            rank: 2,
                            height: 200,
                            color: Colors.grey[700]!,
                          ),
                          // First place
                          buildPodium(
                            robotName: robots[3]['name'],
                            imagePath: robots[3]['image'],
                            rank: 1,
                            height: 250,
                            color: Colors.yellow,
                          ),
                          // Third place
                          buildPodium(
                            robotName: robots[6]['name'],
                            imagePath: robots[6]['image'],
                            rank: 3,
                            height: 150,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.72,
              left: MediaQuery.of(context).size.width * 0.5 - 150,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Ropes
                  Positioned(
                    top: 0,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          width: 2,
                          height: 50,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 276),
                        Container(
                          width: 2,
                          height: 50,
                          color: Colors.blue[700],
                        ),
                      ],
                    ),
                  ),
                  // Sign Board
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue[900]!, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _secondsRemaining > 0
                            ? "Voting ends in ${formatTime(_secondsRemaining)}"
                            : "Voting has ended!",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPodium({
  required String robotName,
  required String imagePath,
  required int rank,
  required double height,
  required Color color,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        robotName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 5),
      ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            height: 300,
            width: 200,
            fit: BoxFit.cover,
          )),
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 200,
            height: height,
            color: color,
          ),
          Positioned(
            top: 20,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                "$rank",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

class RobotCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int currentRating;
  final Function(int) onRatingSelected;
  final String hat;
  final String head;
  final String neck;

  RobotCard({
    required this.name,
    required this.imagePath,
    required this.currentRating,
    required this.onRatingSelected,
    required this.hat,
    required this.head,
    required this.neck,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 75),
              // Star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => onRatingSelected(index + 1),
                    icon: Icon(
                      index < currentRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 75,
                    ),
                  );
                }),
              ),
              //const SizedBox(height: 110),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: RobotCostumes.drawRobot(
                  RobotCostumes(250, imagePath, hat, head, neck),
                ),
              ),
            ],
          ),
        ),
        // Crowd at the bottom
      ],
    );
  }
}

class StagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.red;
    Path leftCurtainPath = Path();
    leftCurtainPath.moveTo(0, 0);
    leftCurtainPath.lineTo(0, size.height * 0.8);
    leftCurtainPath.quadraticBezierTo(
        size.width * 0.15, size.height * 0.3, size.width * 0.2, 0);
    leftCurtainPath.close();
    canvas.drawPath(leftCurtainPath, paint);

    // Draw the right curtain (mirrored left curtain)
    Path rightCurtainPath = Path();
    rightCurtainPath.moveTo(size.width, 0);
    rightCurtainPath.lineTo(size.width, size.height * 0.8);
    rightCurtainPath.quadraticBezierTo(
        size.width * 0.85, size.height * 0.3, size.width * 0.8, 0);
    rightCurtainPath.close();
    canvas.drawPath(rightCurtainPath, paint);

    // Draw the stage floor
    paint.color = Colors.brown[800]!;
    canvas.drawRect(
        Rect.fromLTRB(0, size.height * 0.7, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CrowdPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;

    // Draw semi-circles for heads
    for (double i = 0; i < size.width; i += 200) {
      canvas.drawCircle(Offset(i + 15, size.height - 80), 70, paint);
    }

    // Draw rectangles for shoulders
    paint.color = Colors.black.withOpacity(0.8);
    for (double i = 0; i < size.width; i += 200) {
      canvas.drawRect(Rect.fromLTWH(i, size.height - 40, 30, 40), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
