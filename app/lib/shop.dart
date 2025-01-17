import 'package:app/robotCostumes.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'homePage.dart';

int coins = 100000;

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  final Map<String, List<Item>> categories = {
    'Hats': [
      Item('Top Hat', 'images/TopHat.png', 12000),
      Item('Beanie', 'images/BeanieHat.png', 8000),
      Item('Bucket Hat', 'images/BucketHat.png', 10000),
      Item('Cowboy Hat', 'images/CowboyHat.png', 15000),
      Item('Santa Hat', 'images/SantaHat.png', 18000),
    ],
    'Head Decor': [
      Item('Glasses', 'images/GlassesHead.png', 8000),
      Item('Monocle', 'images/MonocleHead.png', 11000),
      Item('Rad Glasses', 'images/RadGlassesHead.png', 9000),
    ],
    'Neck Decor': [
      Item('Scarf', 'images/ScarfNeck.png', 5000),
      Item('Beard', 'images/BeardNeck.png', 12000),
      Item('Mustache', 'images/MustacheNeck.png', 100),
    ],
  };

  String selectedCategory = 'Hats';
  String? hoveredItemImage;
  String currentRobotImage = 'images/RadRobot.png';

  final Map<String, Map<String, Offset>> accessoryPositions = {
    'images/robot.png': {
      'Hats': Offset(232, -65),
      'Head Decor': Offset(235, 100),
      'Neck Decor': Offset(237, 160),
    },
    'images/FemaleRobot.png': {
      'Hats': Offset(240, -55),
      'Head Decor': Offset(235, 80),
      'Neck Decor': Offset(235, 160),
    },
    'images/RadRobot.png': {
      'Hats': Offset(233, -95),
      'Head Decor': Offset(240, 50),
      'Neck Decor': Offset(230, 105),
    },
    'images/SquareRobot.png': {
      'Hats': Offset(240, -47),
      'Head Decor': Offset(237, 80),
      'Neck Decor': Offset(235, 170),
    },
    'images/WinkingRobot.png': {
      'Hats': Offset(237, -95),
      'Head Decor': Offset(236, 60),
      'Neck Decor': Offset(230, 135),
    },
    'images/OvalRobot.png': {
      'Hats': Offset(260, -97),
      'Head Decor': Offset(260, 50),
      'Neck Decor': Offset(250, 118),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
        Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: StarryNightPainter(),
          ),
    ),
         Column(
          children: [
            SizedBox(height: 20),
            Text('Shop', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            SizedBox(height: 50),
            _buildCoinDisplay(),
            _buildTopButtonsRow(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: RobotCostumes.drawRobot(
                        RobotCostumes(
                            currentRobotImage,
                            selectedCategory == 'Hats' ? (hoveredItemImage ?? '') : '',
                            selectedCategory == 'Head Decor'
                                ? (hoveredItemImage ?? '')
                                : '',
                            selectedCategory == 'Neck Decor'
                                ? (hoveredItemImage ?? '')
                                : ''),
                        (MediaQuery.of(context).size.height) / 2,
                      )
                  ),
                      _buildShopItems(),
                ],
              ),
            ),
          ],
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
    ]),
    );
  }

  Widget _buildCoinDisplay() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.attach_money, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              '$coins',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopButtonsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _switchRobot,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Switch Robot',
                style: TextStyle(color: Colors.white)),
          ),
          ...categories.keys.map((category) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedCategory == category
                    ? Colors.green
                    : Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                category,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _switchRobot() {
    // Add logic to switch between robot models
    List<String> robotImages = [
      'images/robot.png',
      'images/FemaleRobot.png',
      'images/RadRobot.png',
      'images/SquareRobot.png',
      'images/WinkingRobot.png',
      'images/OvalRobot.png',
    ];
    setState(() {
      // Rotate through robot images
      int currentIndex = robotImages.indexOf(currentRobotImage);
      currentRobotImage = robotImages[(currentIndex + 1) % robotImages.length];
    });
  }

  Widget _buildRobotPreview() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(currentRobotImage),
            if (hoveredItemImage != null) _buildAccessoryImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessoryImage() {
    final Offset position = accessoryPositions[currentRobotImage]
            ?[selectedCategory] ??
        const Offset(0, 0);

    return Positioned(
      left: position.dx - 75,
      top: position.dy,
      child: Image.asset(
        hoveredItemImage!,
        height: 165,
        width: 165,
      ),
    );
  }

  Widget _buildShopItems() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories[selectedCategory]?.length ?? 0,
              itemBuilder: (context, index) {
                final item = categories[selectedCategory]![index];
                return MouseRegion(
                  onEnter: (_) => _onItemHover(item.image),
                  onExit: (_) => _onItemHover(null),
                  child: GestureDetector(
                    onTap: () => _showPurchaseDialog(context, item),
                    child: _buildItemCard(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Item item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(item.image, height: 80, width: 80),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${item.price}',
                  style: TextStyle(
                    fontSize: 16,
                    color: item.isPurchased ? Colors.grey : Colors.green,
                    decoration: item.isPurchased
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onItemHover(String? imagePath) {
    setState(() {
      hoveredItemImage = imagePath;
    });
  }

  void _showPurchaseDialog(BuildContext context, Item item) {
    if (item.isPurchased) {
      _showErrorDialog(context, '${item.name} is already purchased.');
      return;
    }

    if (item.price > coins) {
      _showErrorDialog(context, 'Not enough coins to purchase ${item.name}.');
      return;
    }

    setState(() {
      coins -= item.price;
      item.isPurchased = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully purchased ${item.name}!'),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  final String name;
  final String image;
  final int price;
  bool isPurchased;

  Item(this.name, this.image, this.price, {this.isPurchased = false});
}
