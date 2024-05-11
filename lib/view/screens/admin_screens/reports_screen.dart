import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../core/services/admin_service.dart';
import '../../../utils/Router/const_router_names.dart';
import '../../../utils/theme_manager.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportList? reportsList;

  @override
  Widget build(BuildContext context) {
    AdminService adminService = AdminService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: adminService.getReports(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              reportsList = snapshot.data;
              if (reportsList!.reports.isEmpty)
                return const Center(child: Text("NO REPORTS YET"));
              List<String> ids = adminService.placesIds.toList();

              return ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          List<ReportModel> temp = reportsList!.reports
                              .where((element) => element.placeId == ids[index])
                              .toList();
                          Navigator.of(context).pushNamed(
                              placeReportsAdminRoute,
                              arguments: temp).then((value) {
                                setState(() {

                                });
                          });
                        },
                        child: Container(
                            height: 100,
                            color: ThemeManager.second,
                            child: Center(
                                child: Text(
                              "Place Id: ${ids[index]}",
                              style: ThemeManager.textStyle,
                            ))),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
