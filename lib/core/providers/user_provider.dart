import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/user_service.dart';


class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

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
}