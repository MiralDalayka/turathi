import '../../utils/shared.dart';
enum RequestStatus { accepted, rejected,waiting,dataWarning }
class RequestModel {
  String? requestId;
  String? status;
  String? certificate;
  String? userId;



  RequestModel.empty() {
    requestId = "-1";
  }

  RequestModel() {
    requestId = uuid.v4();
    userId = sharedUser.id;
    status = RequestStatus.waiting.name;
  }

  RequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    status = json['status'];
    certificate = json['certificate'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['status'] = this.status;
    data['certificate'] = this.certificate;
    data['userId'] = this.userId;
    return data;
  }
}
