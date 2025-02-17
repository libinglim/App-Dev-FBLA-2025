import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:app/robotCostumes.dart';

import 'homePage.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
  }

  void _equipAccessory(String selectedAccessory) {
    if (selectedAccessory.isNotEmpty) {
      if (selectedAccessory.contains('Hat')) {
        Globals.selectedRobot.hatImage = selectedAccessory;
      } else if (selectedAccessory.contains('Head')) {
        Globals.selectedRobot.headDecorImage = selectedAccessory;
      } else if (selectedAccessory.contains('Neck')) {
        Globals.selectedRobot.neckDecorImage = selectedAccessory;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Inventory',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1D2671),
                Color(0xFFC33764)
              ], // Gradient matching HomePage
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1D2671),
              Color(0xFFC33764)
            ], // Gradient matching HomePage
          ),
        ),
        child: Row(
          children: [
            // Main content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of cards per row
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.6, // Adjusted aspect ratio
                  ),
                  itemCount: Globals.robots.length,
                  itemBuilder: (context, index) {
                    return InventoryItemCard(
                      itemName: 'Item ${index + 1}',
                      imagePath: Globals.robots[index],
                    );
                  },
                ),
              ),
            ),
            // Scrollable image buttons on the right
            Container(
              width: 100, // Fixed width for the scrollable column
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.3), // Semi-transparent background
                border: Border(
                  left: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children:
                      List.generate(Globals.accessories.length + 1, (index) {
                    return index == Globals.accessories.length
                        ? ElevatedButton(
                            onPressed: () {
                              Globals.selectedRobot.hatImage = '';
                              Globals.selectedRobot.headDecorImage = '';
                              Globals.selectedRobot.neckDecorImage = '';
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Icon(Icons.delete,
                                size: 24, color: Colors.white),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _equipAccessory(Globals.accessories[index]);
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        Globals.accessories[index],
                                        fit: BoxFit.cover,
                                        height: 60, // Adjust as needed
                                        width: 60, // Adjust as needed
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Item ${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryItemCard extends StatefulWidget {
  final String itemName;
  final String imagePath;

  const InventoryItemCard({
    Key? key,
    required this.itemName,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<InventoryItemCard> createState() => _InventoryItemCard();
}

class _InventoryItemCard extends State<InventoryItemCard> {
  bool isEditing = false;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    final initialName = Globals.robotNames[widget.imagePath] ?? widget.itemName;
    nameController = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _saveName(String name) {
    Globals.robotNames[widget.imagePath] = name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: RobotCostumes.drawRobot(
                  RobotCostumes(
                    widget.imagePath,
                    Globals.selectedRobot.hatImage,
                    Globals.selectedRobot.headDecorImage,
                    Globals.selectedRobot.neckDecorImage,
                  ),
                  400,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1D2671),
                      Color(0xFFC33764)
                    ], // Gradient matching HomePage
                  ),
                ),
                child: SizedBox(
                  height: 40, // Set the fixed height for the text box
                  child: isEditing
                      ? TextField(
                          controller: nameController,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          onSubmitted: (newValue) {
                            setState(() {
                              isEditing = false;
                              _saveName(newValue); // Save the name to Globals
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter name',
                            hintStyle: TextStyle(color: Colors.white38),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: Center(
                            child: Text(
                              nameController.text,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InventoryItemDetail extends StatefulWidget {
  final String itemName;
  final String imagePath;

  const InventoryItemDetail({
    Key? key,
    required this.itemName,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<InventoryItemDetail> createState() => _InventoryItemDetailState();
}

class _InventoryItemDetailState extends State<InventoryItemDetail> {
  String selectedAccessory = ''; // Store selected accessory
  late RobotCostumes robot;

  @override
  void initState() {
    super.initState();
    robot = RobotCostumes(widget.imagePath, '', '', '');
  }

  void _equipAccessory() {
    if (selectedAccessory.isNotEmpty) {
      if (selectedAccessory.contains('Hat')) {
        robot.hatImage = selectedAccessory;
        Globals.selectedRobot.hatImage = selectedAccessory;
      } else if (selectedAccessory.contains('Head')) {
        robot.headDecorImage = selectedAccessory;
        Globals.selectedRobot.headDecorImage = selectedAccessory;
      } else if (selectedAccessory.contains('Neck')) {
        robot.neckDecorImage = selectedAccessory;
        Globals.selectedRobot.neckDecorImage = selectedAccessory;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1D2671),
                Color(0xFFC33764)
              ], // Gradient matching HomePage
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1D2671),
              Color(0xFFC33764)
            ], // Gradient matching HomePage
          ),
        ),
        child: CustomPaint(
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
    painter: StarryNightPainter(),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            Expanded(
              child: RobotCostumes.drawRobot(robot, 400),
            ),
            // Main content area (Robot preview)

            // Scrollable image buttons on the right
            Container(
              width: 100, // Fixed width for the scrollable column
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(Globals.accessories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAccessory = Globals
                                .accessories[index]; // Select the accessory
                            _equipAccessory();
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  Globals.accessories[index],
                                  fit: BoxFit.cover,
                                  height: 60, // Adjust as needed
                                  width: 60, // Adjust as needed
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Robot ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      floatingActionButton: selectedAccessory.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _equipAccessory();
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}
