import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/comment_model.dart';
import 'package:turathi/core/models/event_model.dart';


class CommentService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "comments";


  Future<String> addComment(CommentModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "comment added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<CommentList> getPlaceComments(String placeId) async {
    QuerySnapshot commentsData =
    await _fireStore.collection(_collectionName)
        .where('placeId', isEqualTo: placeId)
        .get()
        .whenComplete(() {
      log("events done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    CommentModel tempModel;
    CommentList commentList = CommentList(comments: []);
    for (var item in commentsData.docs) {
      data["id"] = item.get("id");
      data["date"] = item.get("date");
      data["commentTxt"] = item.get("commentTxt");
      data["writerName"] = item.get("writerName");
      data["writtenByExpert"] = item.get("writtenByExpert");
      data["placeId"] = item.get("placeId");
      data["questionId"] = item.get("questionId");

      tempModel = CommentModel.fromJson(data);
      commentList.comments.add(tempModel);
    }

    return commentList;
  }

  Future<CommentList> getQuestionComments(String questionId) async {
    QuerySnapshot commentsData =
    await _fireStore.collection(_collectionName)
        .where('questionId', isEqualTo: questionId)
        .get()
        .whenComplete(() {
      log("events done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    CommentModel tempModel;
    CommentList commentList = CommentList(comments: []);
    for (var item in commentsData.docs) {
      data["id"] = item.get("id");
      data["date"] = item.get("date");
      data["commentTxt"] = item.get("commentTxt");
      data["writerName"] = item.get("writerName");
      data["writtenByExpert"] = item.get("writtenByExpert");
      data["placeId"] = item.get("placeId");
      data["questionId"] = item.get("questionId");

      tempModel = CommentModel.fromJson(data);
      commentList.comments.add(tempModel);
    }

    return commentList;
  }
}

