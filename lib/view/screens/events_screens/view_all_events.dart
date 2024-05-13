import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/functions/dialog_signin.dart';
import 'package:turathi/core/providers/event_provider.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/events_screens/widgets/event_widget_view.dart';
import 'package:turathi/view/widgets/add_button.dart';

import '../../../core/models/event_model.dart';
import '../../../utils/Router/const_router_names.dart';
import '../../../utils/layout_manager.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventList? eventList;
  @override
  Widget build(BuildContext context) {
    EventProvider provider = Provider.of<EventProvider>(context);
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
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: FutureBuilder(
        future: provider.eventList,
        builder: (context,snapshot){
          if(snapshot.hasData){
            eventList = snapshot.data;
            if(eventList!.events.isNotEmpty){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: LayoutManager.widthNHeight0(context, 0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ViewEvent(
                          eventModel: eventList!.events[index],
                          height: LayoutManager.widthNHeight0(context, 0) * 0.13,
                          flag: true,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: LayoutManager.widthNHeight0(context, 0) * 0.015,
                      ),
                      itemCount: eventList!.events.length),
                ),
              );
            }
            return const Center(child: Text("NO EVENTS YET"),);
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
