class Report {
  String? reportId;
  String? reasons;
  String? userId;

  Report({this.reportId, this.reasons, this.userId});

  Report.fromJson(Map<String, dynamic> json) {
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
