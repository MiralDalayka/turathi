import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/services/event_service.dart';


class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();

  Future<String> addEvent(EventModel model, List<XFile> images) async {
    String msg = (await _eventService.addEvent(model,images).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<EventList> getEvents() async {
    return await _eventService.getEvents();
  }
}