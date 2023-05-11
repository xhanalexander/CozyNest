import '../../db/db_helper.dart';
import '../../model/user_model.dart';

class AuthServices {
  DBHelper dbHelper = DBHelper();

  Future<bool> isUserRegistered(String username) async {
    UserAuth? user = await dbHelper.getUserByUsername(username);
    return user != null;
  }

  Future<bool> registerUser(String username, String password, String email) async {
    if (await isUserRegistered(username)) {
      return false;
    }

    try {
      final user = UserAuth(username: username, password: password, email: email);
      await dbHelper.createUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser(String username, String password, String email) async {
    UserAuth? user = await dbHelper.getUserByUsername(username);
    if (user != null && user.password == password) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(String username, String password, String email, String newUsername) async {
    UserAuth? user = await dbHelper.getUserByUsername(username);
    if (user != null) {
      final updatedUser = UserAuth(username: newUsername, password: password, email: email);
      await dbHelper.updateUser(updatedUser);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(String username) async {
    UserAuth? user = await dbHelper.getUserByUsername(username);
    if (user != null) {
      await dbHelper.deleteUser(user.id!);
      return true;
    } else {
      return false;
    }
  }
  
}

