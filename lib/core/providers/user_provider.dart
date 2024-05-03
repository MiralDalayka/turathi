import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/user_service.dart';
import 'dart:developer';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserList _userList=UserList(users: []);

  Future<UserList> get userList async {
    if (_userList.users.isEmpty) {
      await _getUsers();
    }
    return _userList;
  }
  Future<String> addUser(UserModel model) async {
    String msg = (await _userService.addUser(model).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<UserModel> updateUser(UserModel model) async {
    return await _userService.updateUser(model).whenComplete(() {
      notifyListeners();
    });
  }
  Future<void> _getUsers() async {
    _userList= await _userService.getUsers().whenComplete(() {
      log("users");
    });
  }

}