// database/sqflite/receipt_database.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/reciept.dart';

class ReceiptDatabaseHelper {
  static final ReceiptDatabaseHelper _instance = ReceiptDatabaseHelper._internal();
  factory ReceiptDatabaseHelper() => _instance;

  ReceiptDatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'receipts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE receipts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            storeName TEXT,
            productType TEXT,
            price REAL,
            discountedPrice REAL,
            totalPrice REAL,
            collectionTime TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertReceipt(Receipt receipt) async {
    final db = await database;
    await db.insert(
      'receipts',
      receipt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Receipt>> getReceipts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('receipts');

    return List.generate(maps.length, (i) {
      return Receipt.fromMap(maps[i]);
    });
  }

  Future<void> clearReceipts() async {
    final db = await database;
    await db.delete('receipts');
  }
}
