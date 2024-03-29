import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/location_screens/body_Places.dart';
import 'package:turathi/view/screens/location_screens/location_header.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _Location_PageState();
}

class _Location_PageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isTabControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!isTabControllerInitialized) {
      setState(() {
        isTabControllerInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.04,
       
      ),
      body: Container(
        color: ThemeManager.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderPart(),
            Padding(
              padding: const EdgeInsets.only(right: 0),//50//
              child: TabBar(
                controller: tabController,
                labelStyle: TextStyle(
                    fontSize: 12,
                    color: ThemeManager.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'KohSantepheap'),
                // Make text bold
                indicatorColor: ThemeManager.second,
                labelColor: ThemeManager.primary,
                unselectedLabelColor: Colors.grey,
                dividerColor: ThemeManager.second,
                tabs: const [
                  Tab(text: 'My Location'),
                  Tab(text: 'Nearest Place'),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                BodyPlaces(tab: 'My Location'),
                isTabControllerInitialized
                    ? BodyPlaces(tab: 'Nearest Place')
                    : Center(child: CircularProgressIndicator()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
