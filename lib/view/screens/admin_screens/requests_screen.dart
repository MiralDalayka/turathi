import 'package:flutter/material.dart';
import 'package:turathi/core/services/admin_service.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/admin_screens/widgets/request_widget.dart';

import '../../../core/models/request_model.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  RequestList? requestList;

  @override
  Widget build(BuildContext context) {
    AdminService adminService = AdminService();

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Requests',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: adminService.getRequests(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            requestList = data;
            if (requestList!.requests.isNotEmpty) {
              return ListView.builder(
                  itemCount: requestList!.requests.length,
                  itemBuilder: (context, index) {
                    return RequestWidget(
                      count: (index + 1).toString(),
                      model: requestList!.requests[index]!,
                    );
                  });
            }
            return Padding(
              padding: EdgeInsets.only(
                  bottom: LayoutManager.widthNHeight0(context, 1) * 0.4),
              child: Center(
                  child: Text(
                "No requests yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontFamily: ThemeManager.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
