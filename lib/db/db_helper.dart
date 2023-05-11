import 'dart:async';
import '../model/user_model.dart';
import 'db.dart';

class DBHelper {
  Future<int> createUser(UserAuth user) async {
    final db = await DatabaseProvider.instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<UserAuth?> getUserByUsername(String username) async {
    final db = await DatabaseProvider.instance.database;
    final result = await db.query('users', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return UserAuth.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(UserAuth user) async {
    final db = await DatabaseProvider.instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await DatabaseProvider.instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
