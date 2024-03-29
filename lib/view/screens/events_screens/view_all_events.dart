import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/events_screens/widgets/event_widget_view.dart';
import 'package:turathi/view/widgets/add_button.dart';

import '../../../core/models/event_model.dart';
import '../../../utils/Router/const_router_names.dart';
import '../../../utils/layout_manager.dart';


class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, required this.eventsList});
final  List<EventModel> eventsList;
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.of(context).pushNamed(addNewEventRoute);
        },
      ),
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.06,
        title: Text(
          "Events",
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: LayoutManager.widthNHeight0(context, 0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ViewEvent(
                 eventModel:widget.eventsList[index] ,
                  height:LayoutManager.widthNHeight0(context, 0)*0.2,
                  flag: true,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: widget.eventsList.length),
        ),
      ),
    );
  }
}


