import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';

import '../../utils/shared.dart';

class EventService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "events";
  final FilesStorageService _filesStorageService = FilesStorageService();

  Future<String> addEvent(EventModel model, List<XFile> images) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() async {
      _filesStorageService.uploadImages(
          imageType: ImageType.eventImages.name,
          folderName: model.id!,
          pickedImages: images!);
      log("Event Done -------------------------");
    }).catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<EventList> getEvents() async {
    QuerySnapshot eventsData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("get events done");
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

      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.eventImages.name, folderName: tempModel.id!);

      eventList.events.add(tempModel);
    }

    return eventList;
  }

  Future<EventModel> updateEvent(
      {required EventModel eventModel, List<XFile>? images}) async {
    QuerySnapshot eventsData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: eventModel.id)
        .get();
    String eventId = eventsData.docs[0].id;
    log(images.toString());
    if (images != null) {
      eventModel.images!.addAll(await _filesStorageService.uploadImages(
          imageType: ImageType.eventImages.name,
          folderName: eventModel.id!,
          pickedImages: images!));
    }
    _fireStore
        .collection(_collectionName)
        .doc(eventId)
        .update(eventModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
    return eventModel;
  }
}
