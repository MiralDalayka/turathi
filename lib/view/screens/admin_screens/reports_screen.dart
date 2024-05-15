import 'package:flutter/material.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/admin_service.dart';
import 'package:turathi/utils/layout_manager.dart';
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
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Admin Reports',
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
          future: adminService.getReports(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              reportsList = snapshot.data;
              if (reportsList!.reports.isEmpty)
                return  Padding(
                 padding:  EdgeInsets.only(bottom:LayoutManager.widthNHeight0(context, 1) * 0.4 ),
                  child: Center(child: Text("NO Reports YET", 
                    style: TextStyle(
                      color: ThemeManager.primary,
                      fontFamily: "KohSantepheap",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,))),
                );
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
