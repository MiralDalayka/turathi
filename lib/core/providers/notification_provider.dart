import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/core/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final _notificationService = NotificationService();

  Future<NotificationList> getUserNotifications(String userId) async {
    return await _notificationService.getUserNotifications(userId);
  }
}
