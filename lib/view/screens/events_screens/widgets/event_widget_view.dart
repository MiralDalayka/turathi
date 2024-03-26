import 'package:flutter/material.dart';

import '../../../../core/models/event_model.dart';
import '../../../../utils/Router/const_router_names.dart';
import '../../../../utils/layout_manager.dart';
import '../../../../utils/theme_manager.dart';

class ViewEvent extends StatelessWidget {
  ViewEvent({super.key, required this.eventModel, this.height, required this.flag});

//eventModel
  final EventModel eventModel;

  double? height;
  bool flag;

  @override
  Widget build(BuildContext context) {
    height ??= LayoutManager.widthNHeight0(context, 0) * 0.15;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(eventDetailsRoute,arguments: eventModel);
      },
      child: Container(
        height: height,
        width: LayoutManager.widthNHeight0(context, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: ThemeManager.second),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                eventModel.images![0],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventModel.name!,
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      color: ThemeManager.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.013,
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.02,
                  ),
                  Text(
                    'Open ⋅ Closes ${eventModel.date!.hour} PM',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      color: ThemeManager.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.013,
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.02,
                  ),
                  Text(
                    'Address: ${eventModel.address!}',
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      color: ThemeManager.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.013,
                    ),
                  ),
                  if (flag!)
                    ...creatorNameFunction(creatorName: eventModel.creatorName!,context:context),
                  if (flag!&&eventModel.ticketPrice!=0)
                    ...ticketPriceFunction(ticketPrice: eventModel.ticketPrice!,context:context),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> creatorNameFunction({required String creatorName, context}) {
  return [
    SizedBox(
      height: LayoutManager.widthNHeight0(context, 1) * 0.02,
    ),
    Text(
      'Creator Name: $creatorName',
      style: TextStyle(
        fontFamily: 'KohSantepheap',
        color: ThemeManager.textColor,
        fontWeight: FontWeight.bold,
        fontSize: LayoutManager.widthNHeight0(context, 0) * 0.013,
      ),
    )
  ];
}
List<Widget> ticketPriceFunction({required double ticketPrice, context}) {
  return [
    SizedBox(
      height: LayoutManager.widthNHeight0(context, 1) * 0.02,
    ),
    Text(
      'Ticket Price: $ticketPrice JOD',
      style: TextStyle(
        fontFamily: 'KohSantepheap',
        color: ThemeManager.textColor,
        fontWeight: FontWeight.bold,
        fontSize: LayoutManager.widthNHeight0(context, 0) * 0.013,
      ),
    )
  ];
}
