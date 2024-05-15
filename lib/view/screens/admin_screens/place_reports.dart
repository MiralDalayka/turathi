import 'package:flutter/material.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/services/admin_service.dart';
import 'package:turathi/utils/layout_manager.dart';
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
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Place Reports Screen',
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
                        adminService
                            .deleteReports(widget.reportList)
                            .whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("The place has been hidden")));
                          Navigator.of(context).pop();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                           ThemeManager.primary), // Change the color to red
                      ),
                      child: Text(
                        "Hide Place",
                        style: TextStyle(color: ThemeManager.second),
                      ))
                ],
              ),
              SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 1.7,
                  child: ListView.builder(
                      itemCount: widget.reportList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(
                              LayoutManager.widthNHeight0(context, 1) * 0.03),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                                height:
                                    LayoutManager.widthNHeight0(context, 1) * 0.4,
                                color: ThemeManager.primary,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      LayoutManager.widthNHeight0(context, 1) *
                                          0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Reported By : ${widget.reportList[index].userId}",
                                        style:  TextStyle(color: ThemeManager.second,fontFamily: ThemeManager.fontFamily,fontSize: 15),
                                      ),
                                     
                                      Text(
                                        textAlign: TextAlign.center,
                                        " Reasons : ${widget.reportList[index].reasons}",
                                        style:   TextStyle(color: ThemeManager.second,fontFamily: ThemeManager.fontFamily,fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
