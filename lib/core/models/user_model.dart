import '../../utils/shared.dart';
import '../functions/modify_data.dart';

enum UsersRole { user, expert }

class UserModel {
  String? id;
  String? name;
  String? password;
  String? role;
  double? longitude;
  double? latitude;
  String? certificate;
  String? email;
  List<String>? favList;
  // String? userid;

  String? phone;
  UserModel.empty();
  UserModel(
      {this.id,
      // this.userid,
      required this.name,
      required pass,
      required this.email,
      required this.phone,
      required this.longitude,
      required this.latitude,
      this.certificate}) {
    role = UsersRole.user.name;
    id = uuid.v4();
    if (pass != null) {
      password = hashPassword(pass);//
    }
    favList=[];
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
    favList = json['favList'].cast<String>();
    //  userid = json['userid'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['role'] = role;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['certificate'] = certificate;
    data['phone'] = phone;
    data['email'] = email;
    data['favList'] = favList;
    //  data['userid'] = userid;

    return data;
  }
}

class UserList {
  List<UserModel> users;

  UserList({required this.users});

  factory UserList.fromJson(List<dynamic> data) {
    List<UserModel> temp = [];
    temp = data.map((item) {
      return UserModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return UserList(users: temp);
  }
}
