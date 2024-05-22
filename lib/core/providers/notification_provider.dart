import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../data_layer.dart';


class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  NotificationList _notificationList = NotificationList(notifications: []);

  Future<NotificationList> get notificationList async {
    if (_notificationList.notifications.isEmpty) {
      await _getNotifications();
    }
    log(_notificationList.notifications.length.toString());
    return _notificationList;
  }
  Future<void> _getNotifications() async {
    _notificationList = await _notificationService.getUserNotifications(sharedUser.id!)
        .whenComplete(() {
          notifyListeners();
          log("Provider get notifications");});
  }

// late Future<NotificationList> _notificationList;
  // bool _loading = false;
  // String? _error;
  //
  // Future<NotificationList> get notificationList => _notificationList;
  // bool get loading => _loading;
  // String? get error => _error;
  //
  // Future<void> fetchNotifications(String userId) async {
  //   _loading = true;
  //   _error = null;
  //   notifyListeners();
  //
  //   try {
  //     _notificationList = _notificationService.getUserNotifications(userId);
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }
}
