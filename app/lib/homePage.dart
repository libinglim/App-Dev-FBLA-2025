import 'package:app/inventoryPage.dart';
import 'package:app/profilePage.dart';
import 'package:app/wheel.dart';
import 'package:app/shop.dart'; // Import your shop page
import 'package:app/questions.dart'; // Import your questions page
import 'package:flutter/material.dart';

int coins = 0; // Global variable for coins

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Create an AnimationController to manage the animation
    _controller = AnimationController(
      duration: Duration(seconds: 1), // Duration of the bounce effect
      vsync: this,
    );

    // Animation that makes the buttons bounce up and down
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // Reverse the animation when completed
        } else if (status == AnimationStatus.dismissed) {
          Future.delayed(Duration(seconds: 5)).then((value) =>
              _controller.forward()); // Restart the bounce when dismissed
        }
      });

    _controller.forward(); // Start the animation immediately
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.yellow[700], // Background of the bar
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
                  Icon(
                    Icons.attach_money, // Gold coin icon
                    color: Colors.green[700], // Gold color
                    size: 24,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '$coins', // Display the amount of gold (global coins variable)
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 30,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    'Build-A-Bot!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              // Tail of the Speech Bubble
              Positioned(
                top: 90,
                child: SizedBox(
                  width: 20,
                  height: 20, // Set the size explicitly
                  child: CustomPaint(
                    painter: SpeechBubbleTailPainter(),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                // Adjust this value to move the robot closer to the speech bubble
                child: Image.asset(
                  'images/OvalRobot.png', // Replace with your robot base image
                  height: 300,
                ),
              ),
              Positioned(
                top: 480,
                // Adjust this value to move the robot closer to the speech bubble
                child:
                    _buildMenuButton('Answer Questions!', Icons.play_arrow, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionsPage(),
                    ),
                  );
                }),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.account_box, // Person icon for profile
                          size: 24,
                          color: Colors.white,
                        ),
                        label: Text('Profile',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          backgroundColor: Colors.blueAccent, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20), // Space between the buttons
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InventoryPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.card_giftcard, // Bag icon for inventory
                          size: 24,
                          color: Colors.white,
                        ),
                        label: Text('Inventory',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          backgroundColor: Colors.green, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Shop Button
                SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopPage(), // Shop Page
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.store, // Store icon for the shop
                          size: 24,
                          color: Colors.white,
                        ),
                        label:
                            Text('Shop', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          backgroundColor: Colors.yellow, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Shiny Spin Button
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
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
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Spin!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String label, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(label, style: const TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class SpeechBubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
