import 'package:app/inventoryPage.dart';
import 'package:app/profilePage.dart';
import 'package:app/questions.dart';
import 'package:app/shop.dart';
import 'package:app/votingPage.dart';
import 'package:app/wheel.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _animation;
  late double height;
  late double width;

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(6) + 3;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
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
            top: 50,
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
                Text(
                  'Build-A-Bot!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -_animation.value),
                      child: Image.asset(
                        'images/OvalRobot.png',
                        height: height / 4,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                _buildMenuButton(
                  'Answer Questions',
                  Icons.question_answer,
                  Colors.blueAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionsPage()),
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuButton(
                  'Profile',
                  Icons.person,
                  Colors.purpleAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuButton(
                  'Inventory',
                  Icons.inventory,
                  Colors.greenAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InventoryPage()),
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuButton(
                  'Shop',
                  Icons.store,
                  Colors.amberAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopPage()),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: -10,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VotingPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purpleAccent,
                  ),
                  padding: const EdgeInsets.all(40),
                  child: const Text(
                    'Vote!',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WheelPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Colors.yellow, Colors.orange],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.7),
                        blurRadius: 30,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(40),
                  child: const Text(
                    'Spin!',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
