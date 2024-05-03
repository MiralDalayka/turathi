import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/functions/calculate_distanceInKm.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/providers/user_provider.dart';

class NotificationService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "notifications";
  final UserProvider _userProvider = UserProvider();
  Future<void> notifyUsers(double placeLatitude, double placeLongitude) async {
    UserList userList = await _userProvider.userList;
    for (var user in userList.users) {
      double distanceInKm = getFormattedDistance(
          calculateDistanceInKm(
            lat1: placeLatitude,
            lon1: placeLongitude,
            lat2: user.latitude!,
            lon2: user.longitude!,
          ),
          10);
      //if distance == 10

      NotificationModel notificationModel =
          NotificationModel(text: "place add", userId: user.id);
      _fireStore
          .collection(_collectionName)
          .add(notificationModel.toJson())
          .whenComplete(() {
        log("Add Place Done");
      });
    }
  }

  Future<NotificationList> getUserNotifications(String userId) async {
    QuerySnapshot notificationsData = await _fireStore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .get()
        .whenComplete(() {
      log("get Notifications done");
    }).catchError((error) {
      log(error.toString());
    });

    Map<String, dynamic> data = {};
    NotificationModel tempModel;
    NotificationList notificationList = NotificationList(notifications: []);
    for (var item in notificationsData.docs) {
      data["id"] = item.get("id");
      data["userId"] = item.get("userId");
      data["text"] = item.get("text");
      data["date"] = item.get("date");

      tempModel = NotificationModel.fromJson(data);
      notificationList.notifications.add(tempModel);
    }
    return notificationList;
  }
}
