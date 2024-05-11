class AdminModel {
  String? adminId;
  String? password;

  AdminModel({this.adminId, this.password});

  AdminModel.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['password'] = this.password;
    return data;
  }
}
