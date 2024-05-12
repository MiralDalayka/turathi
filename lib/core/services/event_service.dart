import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';

import '../../utils/shared.dart';
import 'dart:convert';

class EventService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "events";
  final FilesStorageService _filesStorageService = FilesStorageService();

  Future<EventModel> addEvent(EventModel model, List<XFile> images) async {
    model.images = await _filesStorageService
        .uploadImages(
            imageType: ImageType.eventImages.name,
            folderName: model.id!,
            pickedImages: images!)
        .whenComplete(() {
      _fireStore
          .collection(_collectionName)
          .add(model.toJson())
          .whenComplete(() => log("Event Done -------------------------"));
    }).catchError((error) {
      log(error.toString());

    });
return model;
  }

  Future<EventList> get twoEventsList async {
    QuerySnapshot eventsData =
        await _fireStore.collection(_collectionName).limit(2).get();
    EventModel tempModel;
    EventList eventList = EventList(events: []);
    for (var item in eventsData.docs) {
      tempModel = EventModel.fromJson(item.data() as Map<String, dynamic>);

      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.eventImages.name, folderName: tempModel.id!);

      eventList.events.add(tempModel);
    }

    return eventList;
  }

  Future<EventList> getEvents() async {
    QuerySnapshot eventsData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("get events done");
    }).catchError((error) {
      log(error.toString());
    });
    EventModel tempModel;
    EventList eventList = EventList(events: []);
    for (var item in eventsData.docs) {
      tempModel = EventModel.fromJson(item.data() as Map<String, dynamic>);

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
