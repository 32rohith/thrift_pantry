import 'package:flutter/material.dart';
import 'package:thrift_pantry/components/store_card.dart';
import 'package:thrift_pantry/pages/cart_page/cart_page.dart';
import 'package:thrift_pantry/pages/discover_page/details_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<Map<String, dynamic>> allItems = [
    {
      'imageUrl': 'assets/bp1.png',
      'storeName': 'CK\'s Bakery', 
      'productType': 'Pastries',
      'collectionTime' : '19.00 - 20.00',
      'rating': 4.7,
      'distance':500,
      'originalPrice':450.00,
      'discountedPrice':150.00,
    },
    {
      'imageUrl': 'assets/bp2.png',
      'storeName': 'Madras Bakery', 
      'productType': 'Pastries',
      'collectionTime' : '16.00 - 16.30',
      'rating': 4.8,
      'distance':700,
      'originalPrice':600.00,
      'discountedPrice':250.00,
    },
    {
      'imageUrl': 'assets/bp3.png',
      'storeName': 'McRennett', 
      'productType': 'Pastires',
      'collectionTime' : '10.00 - 11.00',
      'rating': 4.7,
      'distance':400,
      'originalPrice':700.00,
      'discountedPrice':350.00,
    },
    
    {
      'imageUrl': 'assets/rp1.png',
      'storeName': 'A2B', 
      'productType': 'Restaurant',
      'collectionTime' : '21.00 - 21.30',
      'rating': 4.6,
      'distance':900,
      'originalPrice':350.00,
      'discountedPrice':100.00,
    },
    {
      'imageUrl': 'assets/rp2.png',
      'storeName': 'Smoky Docky', 
      'productType': 'Restaurant',
      'collectionTime' : '20.00 - 21.00',
      'rating': 4.9,
      'distance':1200,
      'originalPrice':550.00,
      'discountedPrice':220.00,
    },
    {
      'imageUrl': 'assets/cp1.png',
      'storeName': 'Wow Momos', 
      'productType': 'Cafe',
      'collectionTime' : '14.00 - 15.00',
      'rating': 4.9,
      'distance':700,
      'originalPrice':750.00,
      'discountedPrice':320.00,
    },
    {
      'imageUrl': 'assets/cp2.png',
      'storeName': 'Writer\'s Cafe', 
      'productType': 'Cafe',
      'collectionTime' : '14.00 - 15.00',
      'rating': 4.8,
      'distance':550,
      'originalPrice':450.00,
      'discountedPrice':150.00,
    },
    
  ];

  final List<String> categories = ['All', 'Cafe', 'Pastries', 'Restaurant'];
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
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5)),
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
        pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(
          storeName: item['storeName'],
          productType: item['productType'],
          collectionTime: item['collectionTime'],
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
          );
        },
      ),
    );
  },
  child: CustomCard(item: item), // Display the CustomCard
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
