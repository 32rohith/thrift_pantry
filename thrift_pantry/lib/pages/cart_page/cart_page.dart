import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/farm_cart.dart';
import '../../provider/farm_cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Cart',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
        ),
        iconTheme: IconThemeData(color:Theme.of(context).colorScheme.inversePrimary,),
      ),
      body: Consumer<FarmCartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.items;

          // Check if cart is empty
          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 18),
              ),
            );
          }

          // Calculate total price
          double totalPrice = cartItems.fold(
            0.0,
            (sum, item) => sum + item.discountedPrice,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return _buildCartItem(context, item);
                  },
                ),
              ),
              _buildTotalPriceSection(context, totalPrice),
            ],
          );
        },
      ),
    );
  }

  // Method to build individual cart items
  Widget _buildCartItem(BuildContext context, FarmCartItem item) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productType,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${item.discountedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Deliver By: ${item.deliverBy}', // Assuming there's a deliverBy property
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // Remove the specific item from the cart
                Provider.of<FarmCartProvider>(context, listen: false)
                    .removeItem(item.storeName); // Assuming storeName is unique for each item

                // Show feedback to the user
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from cart'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Total price section at the bottom
  // Total price section at the bottom
Widget _buildTotalPriceSection(BuildContext context, double totalPrice) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary,
          offset: const Offset(0, -1),
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 18,
              ),
            ),
            Text(
              '₹${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            _showConfirmationDialog(context, totalPrice);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: const Text('Buy Now'),
        ),
      ],
    ),
  );
}

  
  // Confirmation dialog for purchase
void _showConfirmationDialog(BuildContext context, double totalPrice) {
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
                'Confirm Purchase',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Are you sure you want to purchase items for ₹${totalPrice.toStringAsFixed(2)}?',
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
                      // Purchase logic and clearing cart
                      Provider.of<FarmCartProvider>(context, listen: false).clearCart();

                      Navigator.of(context).pop(); // Close the dialog

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Purchase successful!'),
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

}
