import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/services/event_service.dart';

class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();

  EventList _eventList = EventList(events: []);
  EventList _twoEventsList = EventList(events: []);

  Future<EventList> get eventList async {
    if (_eventList.events.isEmpty) {
      await _getEvents();
    }
    return _eventList;
  }

  Future<EventList> get twoEventsList async {
    if (_twoEventsList.events.isEmpty) {
      await _getTwoEvents();
    }
    return _twoEventsList;
  }

  Future<void> addEvent(EventModel model, List<XFile> images) async {
    _eventList.events
        .add(await _eventService.addEvent(model, images).whenComplete(() {
      notifyListeners();
    }));
  }

  Future<void> _getEvents() async {
    _eventList = await _eventService.getEvents();

  }
  Future<void> _getTwoEvents() async {
    _twoEventsList = await _eventService.twoEventsList;

  }

  Future<EventModel> updateEvent(
      {required EventModel eventModel, required List<XFile> images}) async {
    log(eventModel.toJson().toString());
    int index = _eventList.events.indexOf(eventModel);
    _eventList.events[index] = await _eventService
        .updateEvent(eventModel: eventModel, images: images)
        .whenComplete(() {
      notifyListeners();
    });
    return eventModel;
  }
}
