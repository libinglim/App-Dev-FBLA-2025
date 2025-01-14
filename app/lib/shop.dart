import 'package:flutter/material.dart';

import 'globals.dart';

// Global variable to keep track of the user's coins
int coins = 100000; // Initial amount of coins

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  // Categories and their respective items
  final Map<String, List<Item>> categories = {
    'Hats': [
      Item('Top Hat', 'images/TopHat.png', 12000),
      Item('Beanie', 'images/Beanie.png', 8000),
      Item('Bucket Hat', 'images/BucketHat.png', 10000),
      Item('Clown Hat', 'images/Clown Hat.png', 9000),
      Item('Cowboy Hat', 'images/CowboyHat.png', 15000),
      Item('Santa Hat', 'images/SantaHat.png', 18000),
    ],
    'Head Decor': [
      Item('Scarf', 'images/Scarf.png', 5000),
      Item('Beard', 'images/Beard.png', 12000),
      Item('Glasses', 'images/Glasses.png', 8000),
      Item('Monocle', 'images/Monocle.png', 11000),
      Item('Mustache', 'images/Mustache.png', 6000),
      Item('Rad Glasses', 'images/RadGlasses.png', 9000),
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

  String selectedCategory = 'Hats'; // Default category
  String? hoveredItemImage; // Image to display when hovering over an item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Row(
        children: [
          // Left side background with robot and hovered image display
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('images/RadRobot.png'),
                if (hoveredItemImage != null)
                  Positioned(
                    top: 50,
                    child: Image.asset(
                      hoveredItemImage!,
                      height: 120,
                      width: 120,
                    ),
                  ),
              ],
            ),
          ),
          // Right side: category buttons and item list
          Expanded(
            child: Column(
              children: [
                // Segment Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categories.keys.map(_buildSegmentButton).toList(),
                ),
                // Item Display
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
                          return MouseRegion(
                            onEnter: (_) => _onItemHover(item.image),
                            onExit: (_) => _onItemHover(null),
                            child: GestureDetector(
                              onTap: () => _showPurchaseDialog(context, item),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(item.image,
                                        height: 100, width: 100),
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

  void _onItemHover(String? imagePath) {
    setState(() {
      hoveredItemImage = imagePath;
    });
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
            '$coins',
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
                  // Check if the user has enough coins
                  if (Globals.coins >= item.price) {
                    setState(() {
                      Globals.coins -=
                          item.price; // Subtract the item price from the coins
                      item.isPurchased = true; // Mark the item as purchased
                      // Add the item to the inventory
                      Globals.inventory.add(
                          item.image); // Add the item's image to the inventory
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
}

class Item {
  final String name;
  final String image;
  final int price;
  bool isPurchased;

  Item(this.name, this.image, this.price, {this.isPurchased = false});
}
