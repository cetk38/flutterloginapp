import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        isAdmin INTEGER NOT NULL
      )
    ''');

    // Admin kullanıcısı ekle
    await db.insert('users', {
      'username': 'admin',
      'password': 'admin123',
      'isAdmin': 1,
    });
  }

  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    final dbClient = await db;
    final res = await dbClient.query('users',
        where: 'username = ? AND password = ?', whereArgs: [username, password]);

    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }

  Future<void> addUser(String username, String password) async {
    final dbClient = await db;
    await dbClient.insert('users', {
      'username': username,
      'password': password,
      'isAdmin': 0,
    });
  }
  Future<List<Map<String, dynamic>>> getAllUsers() async {
  final dbClient = await db;
  return await dbClient.query('users', where: 'isAdmin = ?', whereArgs: [0]);
  }

  Future<void> deleteUser(int id) async {
  final dbClient = await db;
  await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
