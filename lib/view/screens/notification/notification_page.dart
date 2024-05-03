import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/core/providers/notification_provider.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Added Places',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          return FutureBuilder<NotificationList>(
            future: notificationProvider.notificationList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final currentUserID = sharedUser.id; 
                print("!!!!!!!!!!!!!!!!!!$currentUserID");

                final userNotification = snapshot.data!.notifications
                    .where((notification) => notification.userId == currentUserID)
                    .toList();

                if (userNotification.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "There are no notifications for you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView(
                    children: userNotification.map((notification) {
                      return ListTile(
                        title: Text(notification.text ?? ""),
                        subtitle: Text(notification.date?.toString() ?? ""),
                      );
                    }).toList(),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
