import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:app/robotCostumes.dart';

class InventoryPage extends StatefulWidget {
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
        Globals.equippedHat = selectedAccessory;
      } else if (selectedAccessory.contains('Head')) {
        Globals.equippedHead = selectedAccessory;
      } else if (selectedAccessory.contains('Neck')) {
        Globals.equippedNeck = selectedAccessory;
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
                              Globals.equippedHat = '';
                              Globals.equippedHead = '';
                              Globals.equippedNeck = '';
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Icon(Icons.delete,
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryItemDetail(
              itemName: widget.itemName,
              imagePath: widget.imagePath,
            ),
          ),
        );
        setState(() {});
      },
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
                child: RobotCostumes.drawRobot(RobotCostumes(
                    400,
                    widget.imagePath,
                    Globals.equippedHat,
                    Globals.equippedHead,
                    Globals.equippedNeck)),
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
                child: Text(
                  widget.itemName,
                  style: const TextStyle(
                    fontSize: 14, // Smaller font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
    robot = RobotCostumes(400, widget.imagePath, '', '', '');
  }

  void _equipAccessory() {
    if (selectedAccessory.isNotEmpty) {
      if (selectedAccessory.contains('Hat')) {
        robot.hatImage = selectedAccessory;
        Globals.equippedHat = selectedAccessory;
      } else if (selectedAccessory.contains('Head')) {
        robot.headDecorImage = selectedAccessory;
        Globals.equippedHead = selectedAccessory;
      } else if (selectedAccessory.contains('Neck')) {
        robot.neckDecorImage = selectedAccessory;
        Globals.equippedNeck = selectedAccessory;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Expanded(
              child: RobotCostumes.drawRobot(robot),
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
      floatingActionButton: selectedAccessory.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _equipAccessory();
              },
              child: const Icon(Icons.check),
              backgroundColor: Colors.green,
            )
          : null,
    );
  }
}
