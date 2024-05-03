import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/utils/shared.dart';

class NotificationModel {
  String? id;
  String? userId;
  String? text;
  DateTime? date;

  NotificationModel({ required this.userId, required this.text}){
    id = uuid.v4();
    date = DateTime.now();
  }

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
    date = (json["date"] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['date'] = this.date;
    return data;
  }
}
class NotificationList {
  List<NotificationModel> notifications;

  NotificationList({required this.notifications});

  factory NotificationList.fromJson(List<dynamic> data) {

    List<NotificationModel> temp = [];
    temp = data.map((item) {
      return NotificationModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return NotificationList(notifications: temp);
  }
}
