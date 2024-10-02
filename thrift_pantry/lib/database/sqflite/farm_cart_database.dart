import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/farm_cart.dart';

class FarmCartDatabase {
  static final FarmCartDatabase instance = FarmCartDatabase._init();
  static Database? _database;

  FarmCartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('farm_cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE farm_cart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      storeName TEXT,
      productType TEXT,
      deliverBy TEXT,
      rating REAL,
      distance INTEGER,
      originalPrice REAL,
      discountedPrice REAL,
      imageUrl TEXT
    )
    ''');
  }

  Future<void> addItem(FarmCartItem item) async {
    final db = await instance.database;
    await db.insert('farm_cart', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FarmCartItem>> fetchCartItems() async {
    final db = await instance.database;
    final result = await db.query('farm_cart');

    return result.map((json) => FarmCartItem.fromMap(json)).toList();
  }

  Future<void> removeItem(String storeName) async {
    final db = await instance.database;
    await db.delete('farm_cart', where: 'storeName = ?', whereArgs: [storeName]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
