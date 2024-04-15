
class User {
  String? userId;
  String? name;
  String? password;
  String? role;
  double? longitude;
  double? latitude;
  String? certificate;

  User(
      {
        required this.userId,
        required this.name,
        required this.password,
        this.role,
        this.longitude,
        this.latitude,
        this.certificate});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    certificate = json['certificate'];
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
    return data;
  }
}