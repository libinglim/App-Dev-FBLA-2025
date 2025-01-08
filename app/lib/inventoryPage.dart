import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Inventory'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Inventory Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75, // Adjust item height/width ratio
                ),
                itemCount: 10, // Number of inventory items
                itemBuilder: (context, index) {
                  return InventoryItemCard(
                    itemName: 'Item ${index + 1}',
                    imagePath:
                        'assets/item_placeholder.png', // Replace with actual image
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Individual Inventory Items
class InventoryItemCard extends StatelessWidget {
  final String itemName;
  final String imagePath;

  const InventoryItemCard({
    Key? key,
    required this.itemName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Item Image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Item Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
