import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../screens/home_screen.dart';

class NavigationDestination {
  final IconData icon;
  final int index;

  NavigationDestination({
    required this.index,
    required this.icon,
    // required this.selectedColor,
  });
}

class NavigationBar extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double elevation;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;
  final TextStyle labelStyle;

  const NavigationBar({
    super.key,
    required this.backgroundColor,
    required this.height,
    required this.elevation,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: backgroundColor,
      type: BottomNavigationBarType.fixed,
      elevation: elevation,
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              child:Icon( destination.icon,color:selectedIndex == destination.index
                  ? Colors.white
                  : Color(0xff6E232F) ,),
              decoration: BoxDecoration(
                  color: selectedIndex == destination.index
                      ? Color(0xff6E232F)
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            label: '',);
      }).toList(),
      selectedLabelStyle: labelStyle,
      // Add this line
      onTap: onDestinationSelected,
    );
  }
}

class CustomeBottomNavBar extends StatelessWidget {
  const CustomeBottomNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    //fetchProducts();
    // getProducts();
    // print("getProducts funtion");
    // Test();
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Color(0xffF0F2F6),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            return controller.selectedIndex.value = index;
          },
          destinations: [
            NavigationDestination(
              icon: Icons.search,
              index: 0,
            ),
            NavigationDestination(icon: Icons.favorite, index: 1),
            NavigationDestination(
                icon: Icons.label_important_sharp, index: 2),
            NavigationDestination(icon: Icons.person, index: 3),
            NavigationDestination(icon: Icons.person, index: 4),

          ],
          labelStyle: TextStyle(
            fontFamily: 'Kadwa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs; // here the first value was zero
  final screens = [HomeScreen()];
}
