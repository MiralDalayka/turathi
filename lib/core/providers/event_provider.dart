// import 'package:flutter/cupertino.dart';
// import 'package:turathi/core/models/event_model.dart';
// import 'package:turathi/core/services/event_service.dart';
//
//
// class EventProvider extends ChangeNotifier {
//   final EventService _eventService = EventService();
//
//   Future<String> addEvent(EventModel model) async {
//     String msg = (await _eventService.addEvent(model).whenComplete(() {
//       notifyListeners();
//     }));
//     return msg;
//   }
//
//   Future<EventList> getEvents() async {
//     return await _eventService.getEvents();
//   }
// }