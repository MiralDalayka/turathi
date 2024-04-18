
import '../../utils/shared.dart';
import '../functions/modify_data.dart';


enum UsersRole{
  user,
  expert
}

class UserModel {
  String? id;
  String? name;
  String? password;
  String? role;
  double? longitude;
  double? latitude;
  String? certificate;
  String? email;
  String? phone;
  UserModel.empty();
  UserModel(
      {this.id,
      required this.name,
      required pass,
        required this.email,
        required this.phone,
        required this.longitude,
        required this.latitude,
      this.certificate}){
    role=UsersRole.user.name;
    id =uuid.v4();
   password= hashPassword(pass);
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = id;
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