import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/event_model.dart';


class EventService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "events";


  Future<String> addEvent(EventModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "event added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<EventList> getEvents() async {
    QuerySnapshot eventsData =
    await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("events done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    EventModel tempModel;
    EventList eventList = EventList(events: []);
    for (var item in eventsData.docs) {
      data["id"] = item.get("id");
      data["name"] = item.get("name");
      data["date"] = item.get("date");
      data["description"] = item.get("description");
      data["address"] = item.get("address");
      data["longitude"] = item.get("longitude");
      data["latitude"] = item.get("latitude");
      data["ticketPrice"] = item.get("ticketPrice");
      data["creatorName"] = item.get("creatorName");

      tempModel = EventModel.fromJson(data);
      eventList.events.add(tempModel);
    }

    return eventList;
  }
}
