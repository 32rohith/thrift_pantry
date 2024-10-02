import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/farm_cart.dart';
import '../../provider/farm_cart_provider.dart';

class FarmDetailsPage extends StatelessWidget {
  final String storeName;
  final String productType;
  final String deliverBy;
  final double rating;
  final int distance;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;

  const FarmDetailsPage({
    super.key,
    required this.storeName,
    required this.productType,
    required this.deliverBy,
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
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
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
                Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orangeAccent),
                          const SizedBox(width: 5),
                          Text('$rating', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,)),
                          const SizedBox(width: 10),
                          Text('($distance m)', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow('Deliver By:', deliverBy),
                      const SizedBox(height: 10),
                      Text(
                            'Original Price: ₹${originalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Add to Cart Button
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
                  child: const Text('Add to Cart'),
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
      barrierColor: Colors.black54, // Dark background behind the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.surface, // Dark background for the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To fit the content
              children: [
                Text(
                  'Confirm Adding to Cart',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Are you sure you want to add this item to the cart?',
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final cartItem = FarmCartItem(
                          storeName: storeName,
                          productType: productType,
                          deliverBy: deliverBy,
                          rating: rating,
                          distance: distance,
                          originalPrice: originalPrice,
                          discountedPrice: discountedPrice,
                          imageUrl: imageUrl,
                        );
                        
                        // Add item to cart using FarmCartProvider
                        Provider.of<FarmCartProvider>(context, listen: false)
                            .addItem(cartItem);

                        Navigator.of(context).pop(); // Close the dialog

                        // Show success notification
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to cart successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
