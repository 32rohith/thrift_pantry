import 'package:flutter/material.dart';
import '../database/sqflite/farm_cart_database.dart';
import '../models/farm_cart.dart';

class FarmCartProvider with ChangeNotifier {
  List<FarmCartItem> _items = [];

  List<FarmCartItem> get items => _items;

  FarmCartProvider() {
    loadItems();
  }

  Future<void> loadItems() async {
    _items = await FarmCartDatabase.instance.fetchCartItems();
    notifyListeners();
  }

  Future<void> addItem(FarmCartItem item) async {
    await FarmCartDatabase.instance.addItem(item);
    _items.add(item);
    notifyListeners();
  }

  Future<void> removeItem(String storeName) async {
    _items.removeWhere((item) => item.storeName == storeName);
    notifyListeners(); // Notify listeners to update UI
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
