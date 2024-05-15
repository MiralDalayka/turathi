import '../../utils/shared.dart';

enum UsersRole { user, expert }

class UserModel {
  String? id;
  String? name;
  String? role;
  double? longitude;
  double? latitude;
  String? email;
  List<String>? favList;


  String? phone;
  UserModel.empty();
  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.longitude,
      required this.latitude}) {
    role = UsersRole.user.name;
    id = uuid.v4();
    favList=[];
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    longitude = json['longitude'];
    latitude = json['latitude'];

    phone = json['phone'];
    email = json['email'];
    favList = json['favList'].cast<String>();


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['longitude'] = longitude;
    data['latitude'] = latitude;

    data['phone'] = phone;
    data['email'] = email;
    data['favList'] = favList;

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
