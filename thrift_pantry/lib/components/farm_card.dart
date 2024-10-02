import 'package:flutter/material.dart';

class FarmerCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const FarmerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      elevation: 10, // Increased elevation for a more prominent shadow
      color: const Color(0xFF1E1E1E), // Dark background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the image asset
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), // Round top corners
            child: Image.asset(
              item['imageUrl'], // Update to use the correct asset path
              height: 150, // Fixed height for the image
              width: double.infinity, // Full width
              fit: BoxFit.cover, // Cover the entire box without distortion
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  item['storeName'],
                  style: const TextStyle(
                    fontSize: 22, // Increased font size for prominence
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
                const SizedBox(height: 4), // Space between store name and product type
                Text(
                  'Deliver by: ${item['deliveryTime']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300], // Lighter grey for readability
                  ),
                ),
                const SizedBox(height: 8), // Space before the rating and distance
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.green),
                    const SizedBox(width: 4), // Space between icon and text
                    Text(
                      '${item['rating']}',
                      style: const TextStyle(color: Colors.white), // White text for contrast
                    ),
                    const SizedBox(width: 10), // Space between rating and distance
                    const Icon(Icons.location_pin, color: Colors.red),
                    const SizedBox(width: 4), // Space between icon and text
                    Text(
                      '${item['distance']} m',
                      style: const TextStyle(color: Colors.white), // White text for contrast
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Space before price details
                Row(
                  children: [
                    Text(
                      '₹${item['originalPrice']}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold, // Slightly lighter grey for original price
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Add some space at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
