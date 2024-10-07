import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'e_carnisa.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE car_bookings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        brand TEXT,
        model TEXT,
        sewa TEXT,
        harga TEXT
      )
    ''');
  }

  Future<int> insertCarBooking(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('car_bookings', row);
  }
}
