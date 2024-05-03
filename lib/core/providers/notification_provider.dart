// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:turathi/core/models/notification_model.dart';
// import 'package:turathi/core/services/notification_service.dart';

// class NotificationProvider extends ChangeNotifier {


//   final NotificationService _notificationService = NotificationService();

//    final NotificationService notificationService = NotificationService();

//   NotificationList _NotificationList = NotificationList(notifications: []);
  
//   Future<NotificationList> get notificationList async {

//     if (_NotificationList.notifications.isEmpty) {
//       await _getNotification();
//     }
//     log(_NotificationList.notifications.length.toString());
//     return _NotificationList;

    
//   }

//   Future<NotificationList> getUserNotifications(String userId) async {
//     return await _notificationService.getUserNotifications(userId);
//   }

//    Future<void> _getNotification() async {
//     _NotificationList = await _notificationService
//         .getUserNotifications("")//////here add userID
//         .whenComplete(() => {log("Provider get notifications")});
//   }

// }

import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/core/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  late Future<NotificationList> _notificationList;
  bool _loading = false;
  String? _error;

  Future<NotificationList> get notificationList => _notificationList;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchNotifications(String userId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _notificationList = _notificationService.getUserNotifications(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
