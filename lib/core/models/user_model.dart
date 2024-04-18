import 'package:uuid/uuid.dart';

import '../../utils/shared.dart';


enum UsersRole{
  user,
  expert
}

class UserModel {
  String? userId;
  String? name;
  String? password;
  String? role;
  double? longitude;
  double? latitude;
  String? certificate;
  String? email;
  String? phone;

  UserModel(
      {this.userId,
      required this.name,
      required this.password,
        required this.email,
        required this.phone,
        required this.longitude,
        required this.latitude,
      this.certificate}){
    role=(UsersRole.user).toString();
    userId =uuid.v4();


  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    certificate = json['certificate'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['password'] = password;
    data['role'] = role;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['certificate'] = certificate;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
class UserList {
  List<UserModel> users;

  UserList({required this.users});

  factory UserList.fromJson(List<dynamic> data) {
    //1. temp list
    List<UserModel> tempPlaces = [];
    tempPlaces = data.map((item) {
      return UserModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return UserList(users: tempPlaces);
  }
}