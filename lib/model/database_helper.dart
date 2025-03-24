import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:split_receipt/model/classes.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'receipts.db';
  static const String _tableName = 'receipts';

  // Singleton pattern: Return a single instance of the database
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
static Future<Database> _initDatabase() async {
  final appDir = await syspaths.getApplicationDocumentsDirectory(); // Get the app's support directory
  final dbPath = path.join(appDir.path, _databaseName); // Create the full path to the database file

  // Open or create the database at the specified path
  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY,
          name TEXT,
          profiles TEXT,
          items TEXT,
          fees TEXT
        )
      ''');
    },
  );
}


  // Insert a new Receipt into the database
  static Future<int> insertReceipt(Receipt receipt) async {
    final db = await database;
    return await db.insert(_tableName, receipt.toMap());
  }

  // Get a list of all Receipts
  static Future<List<Receipt>> getAllReceipts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Receipt.fromMap(maps[i]);
    });
  }

  // Get a Receipt by id
  static Future<Receipt?> getReceiptById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Receipt.fromMap(maps.first);
    }

    return null;
  }

  // Update an existing Receipt
  static Future<int> updateReceipt(Receipt receipt) async {
    final db = await database;
    return await db.update(
      _tableName,
      receipt.toMap(),
      where: 'id = ?',
      whereArgs: [receipt.id],
    );
  }

  // Delete a Receipt
  static Future<int> deleteReceipt(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
