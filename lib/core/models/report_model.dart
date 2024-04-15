class ReportModel {
  String? reportId;
  String? reasons;
  String? userId;

  ReportModel({this.reportId, this.reasons, this.userId});

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
