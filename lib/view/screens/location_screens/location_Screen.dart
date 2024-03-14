import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';
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
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.04,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ThemeManager.primary,
            ),
            onPressed: () {
           //back
            },
            iconSize: LayoutManager.widthNHeight0(context, 0) * 0.034,
          ),
          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
        ],
      ),
      body: Container(
        color: ThemeManager.background,
        child: Column(
          children: [
            HeaderPart(),
            TabBar(
              controller: tabController,
              tabs: [
                Tab(text: 'My Location'),
                Tab(text: 'Nearest Place'),
              ],
            ),
            Expanded(
              child: isTabControllerInitialized
                  ? TabBarView(
                      controller: tabController,
                      children: [
                          BodyPlaces(tab: 'My Location'),
                        BodyPlaces(tab: 'Nearest Place'),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}