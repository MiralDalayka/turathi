import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/core/providers/question_provider.dart';
import 'package:turathi/core/services/file_storage_service.dart';
import 'package:turathi/utils/shared.dart';


class QuestionService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "questions";
  final FilesStorageService _filesStorageService = FilesStorageService();


  Future<List<String>> addQuestion(QuestionModel model, List<XFile> images) async {
    List<String> url =[];
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() async {
      url= await _filesStorageService.uploadImages(
          imageType: ImageType.questionImages.name,folderName: model.title!, pickedImages: images!);
      log("*******************111****************");
    })
        .catchError((error) {
      log(error.toString());

    });
if(url.isNotEmpty) {
  log("Not empty");
}
    return url;

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
      data["title"] = item.get("title");
      data["questionTxt"] = item.get("questionTxt");
      data["writer"] = item.get("writer");

      tempModel = QuestionModel.fromJson(data);
      tempModel.images =
      await _filesStorageService.getImages(imageType:ImageType.questionImages.name,
          folderName: tempModel.title!);

      questionList.questions.add(tempModel);
    }

    return questionList;
  }
  Future<QuestionModel> getQuestion(String id) async{
    QuerySnapshot questionData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: id)
        .get();
    Map<String, dynamic> data = {};

    QuestionModel tempModel;
    data["id"] = questionData.docs[0].get("id");
    data["title"] = questionData.docs[0].get("title");
    data["questionTxt"] = questionData.docs[0].get("questionTxt");
    data["writer"] = questionData.docs[0].get("writer");

    tempModel = QuestionModel.fromJson(data);
    tempModel.images =
    await _filesStorageService.getImages(imageType:ImageType.questionImages.name,
        folderName: tempModel.title!);

    return tempModel;
  }
}

