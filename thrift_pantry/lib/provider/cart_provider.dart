// cart_model.dart

import 'package:flutter/foundation.dart';

import '../database/sqflite/cart_database.dart';
import '../models/cart.dart';

class CartModel with ChangeNotifier {
  final CartDatabaseHelper _dbHelper = CartDatabaseHelper();
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Fetch cart items from the database
  Future<void> fetchCartItems() async {
    _cartItems = await _dbHelper.getCartItems();
    notifyListeners();
  }

  // Add a cart item
  Future<void> addCartItem(CartItem item) async {
    await _dbHelper.insertCartItem(item);
    await fetchCartItems(); // Refresh the list after adding
  }

  // Clear the cart
  Future<void> clearCart() async {
    await _dbHelper.clearCart();
    _cartItems.clear();
    notifyListeners();
  }
}
