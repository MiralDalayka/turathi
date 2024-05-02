import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/services/event_service.dart';


class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();

   EventList _eventList=EventList(events: []);



  

  Future<EventList> get eventList async{
    if(_eventList.events.isEmpty){
     await _getEvents();
    }
    return _eventList;
  }

  Future<String> addEvent(EventModel model, List<XFile> images) async {
    String msg = (await _eventService.addEvent(model,images).whenComplete(() {
      _getEvents();
      notifyListeners();
    }));
    return msg;
  }

  Future<void> _getEvents() async {
    _eventList= await _eventService.getEvents();
  }
}