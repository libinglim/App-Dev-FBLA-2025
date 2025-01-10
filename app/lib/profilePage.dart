import 'package:app/homePage.dart';
import 'package:app/signInPage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:app/inventoryPage.dart';
import 'package:app/wheel.dart';

import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProfilePage(),
    InventoryPage(),
    WheelPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Menu logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/OvalRobot.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '15',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Level',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  '120',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Quests Completed',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  '2.5k',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Questions Answered',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  '300',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Robo Outlet Wins',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.badge_outlined)),
              ],
            ),
            Container(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(child: Text('Robot ${index + 1}')),
                      );
                    },
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(child: Text('Achievements ${index + 1}')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _pages[index],
            ),
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Inventory'),
          BottomNavigationBarItem(
              icon: Icon(Icons.circle_rounded), label: 'Wheel'),
          //BottomNavigationBarItem(
          //icon: Icon(Icons.question_mark_outlined), label: 'Quests'),
        ],
      ),*/
    );
  }
}
