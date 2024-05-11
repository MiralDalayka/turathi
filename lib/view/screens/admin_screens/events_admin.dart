import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/providers/event_provider.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/screens/admin_screens/edit_event.dart';
import 'package:turathi/view/widgets/event_card.dart';

class eventsAdmin extends StatelessWidget {
  const eventsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; 

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Admin All Events',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          return FutureBuilder<EventList>(
            future: eventProvider.eventList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
            
            

                final userEvents = snapshot.data!.events.toList();

                if (userEvents.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        
                        Padding(
                          padding: EdgeInsets.only(
                              top: LayoutManager.widthNHeight0(context, 1) *
                                  0.5),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "There Is No Events Yet.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: ThemeManager.fontFamily,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                        SizedBox(height: LayoutManager.widthNHeight0(context, 1)*0.05,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          
                          horizontal:
                              LayoutManager.widthNHeight0(context, 1) * 0.05,
                        ),
                        child: GridView.builder(
                          itemCount: userEvents.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: cardWidth / (cardWidth + 65),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            final EventModel = userEvents[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  eventDetailsRoute,
                                  arguments: EventModel,
                                );
                              },
                              child: SizedBox(
                                width: cardWidth,
                                child: EventCard(
                                  eventModel: EventModel,

                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditEvent(
                                          eventModel: EventModel,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
