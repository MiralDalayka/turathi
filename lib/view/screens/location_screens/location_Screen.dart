import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/location_screens/body_Places.dart';
import 'package:turathi/view/screens/location_screens/location_header.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _Location_PageState();
}

class _Location_PageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isTabControllerInitialized = false;

//here

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

        log('selectedNearestLat: $selectedNearestLat, selectedNearestLog: $selectedNearestLog   \n,current long: $userNearestLog,current lat: $userNearestLat ');
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
            const HeaderPart(),
            Padding(
              padding: const EdgeInsets.only(right: 0), //50//
              child: TabBar(
                controller: tabController,
                labelStyle: TextStyle(
                    fontSize: LayoutManager.widthNHeight0(context, 1) * 0.035,
                    color: ThemeManager.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'KohSantepheap'),
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
                    : const Center(child: CircularProgressIndicator()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
