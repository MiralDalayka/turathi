import 'package:flutter/cupertino.dart';
import 'dart:developer';
import '../data_layer.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserList _userList = UserList(users: []);

  Future<UserList> get userList async {
    if (_userList.users.isEmpty) {
      await _getUsers();
    }
    return _userList;
  }

  Future<String> addUser(UserModel model, String password) async {
    String msg = (await _userService.addUser(model, password).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<void> updateUser(UserModel model) async {
    await _userService.updateUser(model.id.toString()).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> updateUserLocation() async {
   await _userService.updateUserLocation().whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> _getUsers() async {
    _userList = await _userService.getUsers().whenComplete(() {
      log("users");
    });
  }

  Future<void> favPlace(String id) async {
    await _userService.addFavoritePlace(id).whenComplete(() {
      sharedUser.favList?.add(id);
    });
    notifyListeners();
  }

  Future<void> removeFavPlace(String id) async {
    await _userService.removeFavoritePlace(id).whenComplete(() {
      sharedUser.favList?.remove(id);
    });
    notifyListeners();
  }

  Future<String> deleteUserProvider() async {
    try {
      await _userService.deleteUser();
      notifyListeners();
      return "User account and data deleted successfully";
    } catch (e) {
      print("Failed to delete user account and data: $e");
      throw e;
    }
  }
}
