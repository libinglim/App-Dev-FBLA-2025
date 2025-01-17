import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart';
import 'robotCostumes.dart';
import 'inventoryPage.dart';
import 'profilePage.dart';
import 'questions.dart';
import 'shop.dart';
import 'votingPage.dart';
import 'wheel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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

  // Function to open Instagram
  void _openInstagram() async {
    const instagramUrl = 'https://www.instagram.com/libinglim/';
    final uri = Uri.parse(instagramUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }

  // Function to open Facebook
  void _openFacebook() async {
    const facebookUrl = 'https://www.facebook.com/libinglim/';
    final uri = Uri.parse(facebookUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Social Media Icons in the Top-Right Corner
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt,
                      color: Colors.purpleAccent, size: 28),
                  onPressed: _openInstagram,
                ),
                IconButton(
                  icon: const Icon(Icons.facebook,
                      color: Colors.blueAccent, size: 28),
                  onPressed: _openFacebook,
                ),
              ],
            ),
          ),
          Positioned(
            top: 225,
            left: 20,
            child: Container(
              width: width / 3.5,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildLeaderboardEntry(1, 'Lily', 79),
                  const Divider(color: Colors.white38),
                  buildLeaderboardEntry(2, 'John', 67),
                  const Divider(color: Colors.white38),
                  buildLeaderboardEntry(3, 'Brady', 58),
                  const Divider(color: Colors.white38),
                  buildLeaderboardEntry(4, 'Emma', 49),
                  const Divider(color: Colors.white38),
                  buildLeaderboardEntry(5, 'Evan', 45),
                ],
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
                const Text(
                  'Build-A-Bot!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -_animation.value),
                      child:
                          RobotCostumes.drawRobot(Globals.selectedRobot, 200),
                    );
                  },
                ),
                const SizedBox(height: 60),
                buildMenuButton(
                  'Answer Questions',
                  Icons.question_answer,
                  Colors.blueAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionsPage()),
                  ),
                ),
                const SizedBox(height: 20),
                buildMenuButton(
                  'Profile',
                  Icons.person,
                  Colors.purpleAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  ),
                ),
                const SizedBox(height: 20),
                buildMenuButton(
                    'Inventory', Icons.inventory, Colors.greenAccent, () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InventoryPage()),
                  );
                  setState(() {});
                }),
                const SizedBox(height: 20),
                buildMenuButton(
                  'Shop',
                  Icons.store,
                  Colors.amberAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopPage()),
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
                  decoration: const BoxDecoration(
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
                      builder: (context) => const WheelPage(),
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

  Widget buildMenuButton(
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

  Widget buildLeaderboardEntry(int rank, String name, int score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$rank. $name',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          '$score wins',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.amberAccent,
          ),
        ),
      ],
    );
  }
}
