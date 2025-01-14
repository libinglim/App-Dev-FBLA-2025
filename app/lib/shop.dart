import 'package:flutter/material.dart';
import 'globals.dart';

// Global variable to keep track of the user's coins
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
      Item('Beanie', 'images/Beanie.png', 8000),
      Item('Bucket Hat', 'images/BucketHat.png', 10000),
      Item('Cowboy Hat', 'images/CowboyHat.png', 15000),
      Item('Santa Hat', 'images/SantaHat.png', 18000),
    ],
    'Head Decor': [
      Item('Glasses', 'images/Glasses.png', 8000),
      Item('Monocle', 'images/Monocle.png', 11000),
      Item('Rad Glasses', 'images/RadGlasses.png', 9000),
    ],
    'Neck Decor': [
      Item('Scarf', 'images/Scarf.png', 5000),
      Item('Beard', 'images/Beard.png', 12000),
      Item('Mustache', 'images/Mustache.png', 6000),
    ],
    'Accessories': [
      Item('Ruler', 'images/Ruler.png', 7000),
      Item('Calculator', 'images/Calculator.png', 15000),
      Item('Candy Cane', 'images/CandyCane.png', 6000),
      Item('Cane', 'images/Cane.png', 10000),
      Item('Carrot', 'images/Carrot.png', 100),
      Item('Positive Sign', 'images/PositiveSign.png', 12000),
    ],
  };

  String selectedCategory = 'Hats';
  String? hoveredItemImage;
  String currentRobotImage = 'images/RadRobot.png';

  final List<String> robotImages = [
    'images/robot.png',
    'images/FemaleRobot.png',
    'images/RadRobot.png',
    'images/SquareRobot.png',
    'images/WinkingRobot.png',
    'images/OvalRobot.png',
  ];

  // Define position offsets for different robots and categories
  final Map<String, Map<String, Offset>> accessoryPositions = {
    'images/robot.png': {
      'Hats': Offset(232, -65),
      'Head Decor': Offset(235, 100),
      'Neck Decor': Offset(237, 160),
      'Accessories': Offset(20, 150),
    },
    'images/FemaleRobot.png': {
      'Hats': Offset(240, -55),
      'Head Decor': Offset(235, 80),
      'Neck Decor': Offset(235, 160),
      'Accessories': Offset(30, 170),
    },
    'images/RadRobot.png': {
      'Hats': Offset(233, -95),
      'Head Decor': Offset(240, 50),
      'Neck Decor': Offset(230, 105),
      'Accessories': Offset(25, 160),
    },
    'images/SquareRobot.png': {
      'Hats': Offset(240, -47),
      'Head Decor': Offset(237, 80),
      'Neck Decor': Offset(235, 170),
      'Accessories': Offset(15, 140),
    },
    'images/WinkingRobot.png': {
      'Hats': Offset(237, -95),
      'Head Decor': Offset(236, 60),
      'Neck Decor': Offset(230, 135),
      'Accessories': Offset(18, 150),
    },
    'images/OvalRobot.png': {
      'Hats': Offset(260, -97),
      'Head Decor': Offset(260, 50),
      'Neck Decor': Offset(250, 118),
      'Accessories': Offset(28, 155),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(currentRobotImage),
                if (hoveredItemImage != null)
                  _buildCategorySpecificPosition(selectedCategory),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _switchRobot,
                      child: const Text('Switch Robot'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                      ),
                    ),
                    ...categories.keys.map(_buildSegmentButton).toList(),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.blue],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: categories[selectedCategory]?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = categories[selectedCategory]![index];
                          return _buildItemCard(item);
                        },
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: _buildCoinDisplay(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _switchRobot() {
    setState(() {
      int nextIndex =
          (robotImages.indexOf(currentRobotImage) + 1) % robotImages.length;
      currentRobotImage = robotImages[nextIndex];
    });
  }

  void _onItemHover(String? imagePath) {
    setState(() {
      hoveredItemImage = imagePath;
    });
  }

  Widget _buildCategorySpecificPosition(String category) {
    Offset position =
        accessoryPositions[currentRobotImage]?[category] ?? Offset(0, 0);

    return Positioned(
      top: position.dy,
      left: position.dx,
      child: Image.asset(
        hoveredItemImage ??
            (category == 'Hats'
                ? 'images/TopHat.png'
                : category == 'Head Decor'
                    ? 'images/Scarf.png'
                    : 'images/Ruler.png'),
        height: 165,
        width: 165,
      ),
    );
  }

  Widget _buildSegmentButton(String category) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedCategory == category ? Colors.green : Colors.blueAccent,
      ),
      child: Text(category),
    );
  }

  Widget _buildCoinDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow[700]!,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.attach_money, color: Colors.green[700], size: 24),
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
    );
  }

  void _showPurchaseDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Purchase ${item.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(item.image, height: 100, width: 100),
              const SizedBox(height: 10),
              Text('Price: \$${item.price}'),
              SizedBox(height: 10),
              Text('You have ${Globals.coins} coins available.'),
              if (item.isPurchased)
                const Text(
                  'You have already purchased this item.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            if (!item.isPurchased)
              TextButton(
                onPressed: () {
                  if (Globals.coins >= item.price) {
                    setState(() {
                      Globals.coins -= item.price;
                      item.isPurchased = true;
                      Globals.inventory.add(item.image);
                    });
                    Navigator.pop(context);
                    _showSuccessDialog(context, item);
                  } else {
                    Navigator.pop(context);
                    _showInsufficientFundsDialog(context);
                  }
                },
                child: const Text('Buy'),
              ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Purchase Successful'),
          content: Text('You have successfully purchased ${item.name}.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showInsufficientFundsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Insufficient Funds'),
          content:
              const Text('You do not have enough coins to purchase this item.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemCard(Item item) {
    return MouseRegion(
      onEnter: (_) => _onItemHover(item.image),
      onExit: (_) => _onItemHover(null),
      child: GestureDetector(
        onTap: () => _showPurchaseDialog(context, item),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Image.asset(item.image, height: 100, width: 100),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: item.isPurchased
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Text(
                '\$${item.price}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  decoration: item.isPurchased
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
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
