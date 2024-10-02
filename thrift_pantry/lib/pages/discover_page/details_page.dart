import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../provider/cart_provider.dart';
import '../payment_page/payment_page.dart';

class DetailsPage extends StatelessWidget {
  final String storeName;
  final String productType;
  final String collectionTime;
  final double rating;
  final int distance;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;

  const DetailsPage({
    super.key,
    required this.storeName,
    required this.productType,
    required this.collectionTime,
    required this.rating,
    required this.distance,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary,),
        title: Text(
          productType,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Extra padding for the button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full-width Image
                Stack(
                  children: [
                    Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), // Glassy effect
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            storeName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orangeAccent),
                              const SizedBox(width: 5),
                              Text(
                                '$rating',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '($distance m)',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Collection and Picking Time
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Collection Time: ', collectionTime,context),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'WHAT WOULD YOU GET',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'It\'s a surprise! When you buy a Surprise Bag, it will be filled with the delicious food!',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                // Price Info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Original Price: ₹${originalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            'Discounted Price: ₹${discountedPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Reserve Now Button pinned to the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9, // Make the button take 90% of the screen width
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Reserve Now'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87, // Dark background behind the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black87, // Dark background for the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To fit the content
              children: [
                const Text(
                  'Confirm Reservation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Are you sure you want to reserve this item?',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                        backgroundColor: Colors.redAccent,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false).addCartItem(
                          CartItem(
                            storeName: storeName,
                            productType: productType,
                            collectionTime: collectionTime,
                            rating: rating,
                            distance: distance,
                            originalPrice: originalPrice,
                            discountedPrice: discountedPrice,
                            imageUrl: imageUrl,
                          ),
                        );
                        
                        // Navigate to the PaymentPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PaymentPage(), // Replace with your PaymentPage class
                          ),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[700]),
        ),
        Text(
          value,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ],
    );
  }
}
