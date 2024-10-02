// cart_database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/cart.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();

  factory CartDatabaseHelper() {
    return _instance;
  }

  CartDatabaseHelper._internal();

  Database? _database;

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart_items('
          'storeName TEXT, '
          'productType TEXT, '
          'collectionTime TEXT, '
          'rating REAL, '
          'distance INTEGER, '
          'originalPrice REAL, '
          'discountedPrice REAL, '
          'imageUrl TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert a new cart item
  Future<void> insertCartItem(CartItem item) async {
    final db = await database;
    await db.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all cart items
  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');

    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  // Clear all cart items
  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart_items');
  }
}
