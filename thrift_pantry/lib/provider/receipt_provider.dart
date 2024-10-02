// providers/receipt_model.dart

import 'package:flutter/foundation.dart';
import '../database/sqflite/receipt_database.dart';
import '../models/reciept.dart';

class ReceiptModel with ChangeNotifier {
  final ReceiptDatabaseHelper _dbHelper = ReceiptDatabaseHelper();
  List<Receipt> _receipts = [];

  List<Receipt> get receipts => _receipts;

  // Fetch receipts from the database
  Future<void> fetchReceipts() async {
    _receipts = await _dbHelper.getReceipts();
    notifyListeners();
  }

  // Add a receipt
  Future<void> addReceipt(Receipt receipt) async {
    await _dbHelper.insertReceipt(receipt);
    await fetchReceipts(); // Refresh the list after adding
  }

  // Clear all receipts
  Future<void> clearReceipts() async {
    await _dbHelper.clearReceipts();
    _receipts.clear();
    notifyListeners();
  }
}
