import 'package:flutter/material.dart';

import '../../../../core/models/event_model.dart';
import '../../../../utils/Router/const_router_names.dart';
import '../../../../utils/layout_manager.dart';
import '../../../../utils/theme_manager.dart';
import '../../../widgets/ui_helper.dart';

class ViewEvent extends StatelessWidget {
  ViewEvent({
    super.key,
    required this.eventModel,
    this.height,
    required this.flag,
  });


  final EventModel eventModel;
  double? height;
  bool flag;

  @override
  Widget build(BuildContext context) {
    height ??= LayoutManager.widthNHeight0(context, 0) * 0.145; //here the height
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(eventDetailsRoute, arguments: eventModel);
      },
      child: Container(
        height: height,
        width: LayoutManager.widthNHeight0(context, 1),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: ThemeManager.second,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width:  LayoutManager.widthNHeight0(context, 1)*0.35, ///here the width
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  eventModel.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: LayoutManager.widthNHeight0(context, 1) * 0.02,
            ), //2
            Padding(
              padding: EdgeInsets.all(
                  LayoutManager.widthNHeight0(context, 1) * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  autoTextFunction(txt: eventModel.name!, maxLine: 3),
                  
                  autoTextFunction(
                    txt: 'Address: ${eventModel.address!}',
                    maxLine: 3,
                  ),
                  if (flag)
                    autoTextFunction(
                      txt: 'Creator Name: ${eventModel.creatorName!}',
                    ),
                  if ( eventModel.ticketPrice != 0)
                    autoTextFunction(
                      txt: 'Ticket Price: ${eventModel.ticketPrice!}',
                    )
                    else if ( eventModel.ticketPrice == 0)
                    autoTextFunction(
                      txt: 'Ticket Price: Free',
                    )

                    
                   
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
