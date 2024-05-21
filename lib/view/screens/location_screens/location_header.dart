import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:turathi/core/functions/get_user_city.dart';
import 'package:turathi/core/services/google_map_api.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

import '../../../utils/shared.dart';

class HeaderPart extends StatefulWidget {
  HeaderPart({super.key, required this.tab});

  String tab;

  @override
  State<HeaderPart> createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      String address = await UserCity(
          longitude: sharedUser.longitude!, latitude: sharedUser.latitude!);
      if (mounted) {
        setState(() {
          _currentAddress = address;
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Location',
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.primary,
                fontWeight: FontWeight.bold,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                shadows: const [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                  size: LayoutManager.widthNHeight0(context, 0) * 0.015,
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                ),
                Text(
                  _currentAddress != null ? _currentAddress! : 'Waiting',
                  style: TextStyle(
                    fontFamily: ThemeManager.fontFamily,
                    color: Colors.grey,
                    fontSize: LayoutManager.widthNHeight0(context, 0) * 0.014,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 1) * 0.028,
            ),
            ////////////////////
            if (widget.tab == "Nearest Place")
              _locationButton(onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NearestMap(),
                  ),
                );
              }, txt: "Choose The Nearest Point")

            else //update user loc

              _locationButton(onTab: () {}, txt: "Update My Location"),
            SizedBox(
              height: LayoutManager.widthNHeight0(context, 0) * 0.005,
            ),
          ],
        ),
      ),
      /////here
    );
  }

  Widget _locationButton(
      {required String txt, required void Function() onTab}) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: LayoutManager.widthNHeight0(context, 1) * 0.145,
        width: LayoutManager.widthNHeight0(context, 0),
        decoration: BoxDecoration(
          color: ThemeManager.second,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 2,
              offset: const Offset(-1, -1),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: ThemeManager.primary,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              txt,
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.primary,
                fontWeight: FontWeight.bold,
                fontSize:
                LayoutManager.widthNHeight0(context, 0) * 0.0175,
                shadows: const [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: LayoutManager.widthNHeight0(context, 0) * 0.015,
            ),
            Icon(
              Icons.map_outlined,
              color: ThemeManager.primary,
              size: LayoutManager.widthNHeight0(context, 0) * 0.023,
            )
          ],
        ),
      ),
    );
  }
}

