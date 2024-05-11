import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../utils/theme_manager.dart';

class PlaceReportsScreen extends StatefulWidget {
  const PlaceReportsScreen({super.key, required this.reportList});

  final List<ReportModel> reportList;

  @override
  State<PlaceReportsScreen> createState() => _PlaceReportsScreenState();
}

class _PlaceReportsScreenState extends State<PlaceReportsScreen> {
  @override
  Widget build(BuildContext context) {
    AdminService adminService = AdminService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Reports Screen"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Number of reports: ${widget.reportList.length}",
                    style: ThemeManager.textStyle.copyWith(fontSize: 14),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        adminService.updatePlaceVisibility(
                            placeId: widget.reportList[0].placeId!,
                            isVisible: false);
                        adminService.deleteReports(widget.reportList).whenComplete(() {
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The place is hidden")));
Navigator.of(context).pop();
                        });
                      },
                      child: Text(
                        "Hide Place",
                        style: TextStyle(color: ThemeManager.primary),
                      ))
                ],
              ),
              SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: widget.reportList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 100,
                              color: ThemeManager.second,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reasons: ${widget.reportList[index].reasons}",
                                    style: ThemeManager.textStyle,
                                  ),
                                  Text(
                                    "Reported by: ${widget.reportList[index].userId}",
                                    style: ThemeManager.textStyle,
                                  ),
                                ],
                              )),
                        );
                      }))
            ],
          )),
    );
  }
}
