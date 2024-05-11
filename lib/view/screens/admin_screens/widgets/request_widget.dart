import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:turathi/core/services/admin_service.dart';

import '../../../../core/models/request_model.dart';
import '../../../../utils/theme_manager.dart';

class RequestWidget extends StatefulWidget {
  RequestWidget({super.key, required this.count, required this.model});

  String count;
  RequestModel model;

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  TextStyle style = ThemeManager.textStyle
      .copyWith(fontSize: 16, color: ThemeManager.primary);

  @override
  Widget build(BuildContext context) {
    AdminService service = AdminService();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 150,
          color: ThemeManager.second,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.count, style: style),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.model.status!, style: style),
                  TextButton.icon(
                      icon: Icon(
                        Icons.picture_as_pdf,
                        color: ThemeManager.primary,
                      ),
                      onPressed: () {
                        log("pdf");
                      },
                      label: Text(
                        "Download",
                        style: style,
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.model.status = RequestStatus.accepted.name;
                          service.updateRequestStatus(
                              requestStatus: RequestStatus.accepted,
                              requestModel: widget.model);
                        });
                      },
                      child: const Text("Accept")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.model.status = RequestStatus.rejected.name;
                          service.updateRequestStatus(
                              requestStatus: RequestStatus.rejected,
                              requestModel: widget.model);
                        });
                      },
                      child: const Text("Reject"))
                ],
              )
            ],
          )),
    );
  }
}
