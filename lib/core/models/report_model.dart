import 'package:turathi/utils/shared.dart';

class ReportModel {
  String? reportId;
  String? reasons;
  String? userId;
  String? placeId;

  ReportModel.empty() {
    reportId = "-1";
  }
  ReportModel({required this.reasons,required this.placeId})
  {
    reportId = uuid.v4();
    userId = sharedUser.id;
  }

  ReportModel.fromJson(Map<String, dynamic> json) {
    reportId = json['reportId'];
    reasons = json['reasons'];
    userId = json['userId'];
    placeId = json['placeId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportId'] = this.reportId;
    data['reasons'] = this.reasons;
    data['userId'] = this.userId;
    data['placeId'] = this.placeId;

    return data;
  }
}

class ReportList {
  List<ReportModel> reports;

  ReportList({required this.reports});

  factory ReportList.fromJson(List<dynamic> data) {

    List<ReportModel> temp = [];
    temp = data.map((item) {
      return ReportModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return ReportList(reports: temp);
  }
}
