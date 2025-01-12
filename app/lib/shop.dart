import 'package:flutter/material.dart';

// Global variable to keep track of the user's coins
int coins = 100000; // Initial amount of coins

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  // List of items in the shop, each with a name, image, price, and purchase status
  final List<Item> items = [
    Item('Item 1', 'images/Mustache.png', 5000),
    Item('Item 2', 'images/Ruler.png', 10000),
    Item('Item 3', 'images/SantaHat.png', 15000),
    Item('Item 4', 'images/Scarf.png', 20000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Row(
        children: [
          // Left side: SizedBox taking up half of the screen width
          SizedBox(
            width: MediaQuery.of(context).size.width /
                2, // Half of the screen width
            child: Container(
              color: Colors.deepPurple, // Set a background color if desired
            ),
          ),
          // Right side: List of items for sale
          Expanded(
            child: Stack(
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
                // ListView of items
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        // Show confirmation dialog when an item is clicked
                        _showPurchaseDialog(context, item);
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Image.asset(item.image,
                                height: 100, width: 100), // Preview
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
                    );
                  },
                ),
                // Coins display
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
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
                          Icons.attach_money,
                          color: Colors.green[700],
                          size: 24,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '$coins', // Display the amount of coins
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dialog to show when an item is clicked
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
              SizedBox(height: 10),
              Text('Price: \$${item.price}'),
              SizedBox(height: 10),
              Text('You have $coins coins available.'),
              if (item.isPurchased)
                Text(
                  'You have already purchased this item.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            if (!item.isPurchased)
              TextButton(
                onPressed: () {
                  // Check if the user has enough coins
                  if (coins >= item.price) {
                    setState(() {
                      coins -=
                          item.price; // Subtract the item price from the coins
                      item.isPurchased = true; // Mark the item as purchased
                    });
                    Navigator.pop(context); // Close the dialog
                    _showSuccessDialog(context, item); // Show success message
                  } else {
                    Navigator.pop(context); // Close the dialog
                    _showInsufficientFundsDialog(
                        context); // Show insufficient funds dialog
                  }
                },
                child: Text('Buy'),
              )
            else
              TextButton(
                onPressed:
                    null, // Disable the buy button for already purchased items
                child: Text('Already Purchased'),
              ),
          ],
        );
      },
    );
  }

  // Dialog to show when the user doesn't have enough coins
  void _showInsufficientFundsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Insufficient Funds'),
          content: Text('You do not have enough coins to purchase this item.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to show when the purchase is successful
  void _showSuccessDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text('You have successfully purchased ${item.name}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Model class to represent each item in the shop
class Item {
  final String name;
  final String image;
  final int price;
  bool isPurchased; // Track whether the item is purchased

  // Constructor with default value for isPurchased
  Item(this.name, this.image, this.price, {this.isPurchased = false});
}
