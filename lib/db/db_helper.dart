import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  static const String tableName = 'users';
  static const String columnId = 'id';
  static const String columnUsername = 'username';
  static const String columnEmail = 'email';
  static const String columnPassword = 'password';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'auth.db');

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  void _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnUsername TEXT,
        $columnEmail TEXT,
        $columnPassword TEXT
      )
    ''');
  }

  Future<int> insertUser(UserAuth user, String emails) async {
    final db = await instance.database;
    return await db.insert(tableName, user.toMap());
  }

  Future<UserAuth?> getUser(String username, String password) async {
    final db = await instance.database;
    final users = await db.query(tableName,
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, password]);
    if (users.isEmpty) {
      return null;
    }
    return UserAuth.fromMap(users.first);
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    final db = await instance.database;
    final users = await db.query(tableName, where: '$columnEmail = ?', whereArgs: [email]);
    return users.isNotEmpty;
  }
}
