import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../utils/theme_manager.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportList? requestList;

  @override
  Widget build(BuildContext context) {
    AdminService adminService = AdminService();

    return Scaffold(
      appBar: AppBar(title: Text("Reports"),
        centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
         future: adminService.getReports(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
requestList=snapshot.data;
              return ListView.builder(
                  itemCount: requestList!.reports.length,
                  itemBuilder: (context, index) {

                return ReportWidget( requestList!.reports[index]);
              });
            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}

Widget ReportWidget(ReportModel model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 150,
        color: ThemeManager.second,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(model.placeId!),
            Text(model.userId!),
            Text(model.reasons!),
            Text(model.reportId!),

          ],
        )),
  );
}