
import 'package:flutter/material.dart';
import 'package:turathi/utils/lib_organizer.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.txt, required this.routeName});
 final String routeName;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          
          height: 100,
          color:ThemeManager.primary ,
          child: Center(
            child: InkWell(
              child: Text(
                txt,
                style: ThemeManager.textStyle.copyWith(color: ThemeManager.second),
              ),
               onTap: (){
                 Navigator.of(context).pushNamed(routeName);
               },
            ),
          )
        ),
      ),
    );
  }
}


List buttonsList = [
  ButtonWidget(txt: "Reports",routeName: allReportsAdminRoute),
  ButtonWidget(txt: "Places",routeName: placesAdminRoute),
  ButtonWidget(txt: "Requests",routeName: requestsAdminRoute),
  ButtonWidget(txt: "Events",routeName: eventsAdminRoute),
   
 
];

