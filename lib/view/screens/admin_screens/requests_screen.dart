import 'package:flutter/material.dart';
import 'package:turathi/core/services/admin_service.dart';
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
      appBar:  AppBar(title: Text("Requests"),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: adminService.getRequests(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator(),);
            }
            requestList = data;
            if (requestList!.requests.isNotEmpty) {
              return ListView.builder(
                  itemCount:requestList!.requests.length ,
                  itemBuilder: (context, index) {

                return RequestWidget(
                  count: (index+1).toString(),
                model: requestList!.requests[index]!,
                );
              });
            }
            return const Center(child: Text("No requests yet"));
          },
        ),
      ),
    );
  }
}
