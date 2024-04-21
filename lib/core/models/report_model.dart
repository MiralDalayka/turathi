import 'package:turathi/utils/shared.dart';

class ReportModel {
  String? reportId;
  String? reasons;
  String? userId;

  ReportModel({required this.reasons})
  {
    reportId = uuid.v4();
    userId = user.id;
  }

  ReportModel.fromJson(Map<String, dynamic> json) {
    reportId = json['reportId'];
    reasons = json['reasons'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportId'] = this.reportId;
    data['reasons'] = this.reasons;
    data['userId'] = this.userId;
    return data;
  }
}
