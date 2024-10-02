// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/sqflite/receipt_database.dart';
import '../../models/cart.dart';
import '../../models/reciept.dart';
import '../../provider/cart_provider.dart';
import 'delivery_progress_page.dart'; // Import the DeliveryProgressPage

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showPaymentConfirmationDialog(context);
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }

  void _showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text("You are about to make a payment."),
              Text("This is a simulated payment."),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Proceed with the simulated payment process
              Navigator.pop(context); // Close the dialog

              // Retrieve the cart items and create a Receipt
              await _createReceipt(context);

              // Navigate to the DeliveryProgressPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeliveryProgressPage()),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> _createReceipt(BuildContext context) async {
    // Access the cart provider to get the cart items
    var cartProvider = Provider.of<CartModel>(context, listen: false);
    
    // Fetch the cart items
    await cartProvider.fetchCartItems(); // Fetch the latest cart items

    // Retrieve the cart items after fetching
    List<CartItem> cartItems = cartProvider.cartItems; // Access the cart items

    if (cartItems.isNotEmpty) {
      // Assume the first item is used for creating the receipt
      CartItem item = cartItems.first;

      // Create the Receipt object
      Receipt receipt = Receipt(
        storeName: item.storeName,
        productType: item.productType,
        price: item.originalPrice,
        discountedPrice: item.discountedPrice,
        totalPrice: item.discountedPrice, // Assuming the total is the discounted price for simplicity
        collectionTime: item.collectionTime,
        date: DateTime.now().toString(), // Current date and time
      );

      // Save the receipt to the database
      ReceiptDatabaseHelper receiptDb = ReceiptDatabaseHelper();
      await receiptDb.insertReceipt(receipt); // Assuming this method inserts the receipt into your database
    }
  }
}
