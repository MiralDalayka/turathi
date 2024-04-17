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
      this.email,
      this.phone,
      this.role,
      this.longitude,
      this.latitude,
      this.certificate});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['role'] = this.role;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['certificate'] = this.certificate;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
