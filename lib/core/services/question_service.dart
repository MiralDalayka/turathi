import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/question_model.dart';


class QuestionService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "questions";


  Future<String> addQuestion(QuestionModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "question added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<QuestionList> getQuestions() async {
    QuerySnapshot questionsData =
    await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("questions done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    QuestionModel tempModel;
    QuestionList questionList = QuestionList( questions: []);
    for (var item in questionsData.docs) {
      data["id"] = item.get("id");
      data["imageUrl"] = item.get("imageUrl");
      data["title"] = item.get("title");
      data["questionTxt"] = item.get("questionTxt");
      data["writer"] = item.get("writer");


      tempModel = QuestionModel.fromJson(data);
      questionList.questions.add(tempModel);
    }

    return questionList;
  }
}

