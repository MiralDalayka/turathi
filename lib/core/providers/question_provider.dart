import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';
import 'package:turathi/core/services/question_service.dart';
import 'package:turathi/utils/shared.dart';



class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();
 QuestionList _questionList=QuestionList(questions: []);
  final FilesStorageService _filesStorageService = FilesStorageService();
  Future<QuestionList> get questionList  async{
    if(_questionList.questions.isEmpty){
    await  _getQuestions();
    }
    log("_questionList");
    return _questionList;
  }



  Future<String> addQuestion(QuestionModel model, List<XFile> images) async {
    _questionList.questions.add (await _questionService.addQuestion(model,images).whenComplete(()  {
      log("*******************222****************");
      notifyListeners();
    }));
    log("*******************333****************");

    return "done";
  }

  Future<void> _getQuestions() async {
    log("get question done");
    _questionList= await _questionService.getQuestions();
  }
}