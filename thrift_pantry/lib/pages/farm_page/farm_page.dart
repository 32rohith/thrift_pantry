import 'package:flutter/material.dart';
// import 'package:thrift_pantry/pages/discover_page/details_page.dart';

import '../../components/farm_card.dart';
import '../cart_page/cart_page.dart';
import 'farm_details.dart';

class FarmPage extends StatefulWidget {
  const FarmPage({super.key});

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  final List<Map<String, dynamic>> allItems = [
    {
      'imageUrl': 'assets/fp1.png',
      'storeName': 'Milk', 
      'productType': 'Dairy',
      'deliveryTime' : '19.00 - 20.00',
      'rating': 4.7,
      'distance':500,
      'originalPrice':450.00,
      'discountedPrice':150.00,
    },
  ];

  final List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy'];
  String selectedCategory = 'All'; // Initially selected category
  String currentAddress = "Current Address"; // Default address

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Address Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _showAddressDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentAddress,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ],
            ),
            const SizedBox(height: 25),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.inversePrimary.withOpacity(.1),
                ),
                child: TextFormField(
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.store,
                      color: Theme.of(context).colorScheme.inversePrimary.withOpacity(.3),
                    ),
                    border: InputBorder.none,
                    hintText: "Find Your Stores...",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary.withOpacity(.3),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Category Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index]; // Change selected category
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategory == categories[index]
                              ? Colors.orange // Active category color
                              : Theme.of(context).colorScheme.inversePrimary, // Inactive category color
                          fontWeight: selectedCategory == categories[index]
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            // Expanded List of Category Items
            Expanded(
              child: _buildCategoryItems(selectedCategory),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItems(String category) {
    List<Map<String, dynamic>> filteredItems = _filterItemsByCategory(category);

    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          "No items available",
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700), // Increased duration for a smoother animation
        pageBuilder: (context, animation, secondaryAnimation) => FarmDetailsPage(
                  storeName: item['storeName'],
                  productType: item['productType'],
                  deliverBy: item['deliveryTime'], // Delivery time instead of collection time
                  rating: item['rating'],
                  distance: item['distance'],
                  originalPrice: item['originalPrice'],
                  discountedPrice: item['discountedPrice'],
                  imageUrl: item['imageUrl'],
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Zoom-in animation
          var scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          // Fade-in animation
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          // Slide-up animation (optional for a subtle effect)
          var slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            ),
          );},
              ),
            );
          },
          child: FarmerCard(item: item), // Use the FarmerCard here
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterItemsByCategory(String category) {
    if (category == 'All') {
      return allItems; // Return all items for the "All" category
    }

    // Filter items based on the productType
    return allItems.where((item) => item['productType'] == category).toList();
  }

  void _showAddressDialog(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Address'),
          content: TextField(
            controller: addressController,
            decoration: const InputDecoration(hintText: "Enter your address"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  currentAddress = addressController.text; // Update address
                });
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
