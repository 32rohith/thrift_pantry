import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/reciept.dart';
import '../../provider/receipt_provider.dart';
import '../discover_page/discover_page.dart'; // Ensure this is the correct path to your DiscoverPage

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  late ReceiptModel _receiptProvider;
  Receipt? _latestReceipt;

  @override
  void initState() {
    super.initState();
    _receiptProvider = Provider.of<ReceiptModel>(context, listen: false);
    _fetchLatestReceipt();
  }

  Future<void> _fetchLatestReceipt() async {
    await _receiptProvider.fetchReceipts(); // Fetch all receipts
    setState(() {
      if (_receiptProvider.receipts.isNotEmpty) {
        _latestReceipt = _receiptProvider.receipts.last; // Get the latest receipt
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Delivery Progress'),
        backgroundColor: Colors.transparent,
      ),
      body: _latestReceipt == null ? _buildLoadingIndicator() : _buildReceiptDetails(_latestReceipt!),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildReceiptDetails(Receipt receipt) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receipt Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Store Name: ${receipt.storeName}', style: const TextStyle(fontSize: 18)),
          Text('Product Type: ${receipt.productType}', style: const TextStyle(fontSize: 18)),
          Text('Original Price: \$${receipt.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
          Text('Discounted Price: \$${receipt.discountedPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
          Text('Total Price: \$${receipt.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
          Text('Collection Time: ${receipt.collectionTime}', style: const TextStyle(fontSize: 18)),
          Text('Date: ${receipt.date}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiscoverPage()), // Navigate to DiscoverPage
                );
              },
              child: const Text('Go to Discover Page'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: const Center(
        child: Text(
          'Thank you for your order!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
