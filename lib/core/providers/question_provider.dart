import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data_layer.dart';


class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();
  QuestionList _questionList=QuestionList(questions: []);
  
  Future<QuestionList> get questionList  async{
    if(_questionList.questions.isEmpty){
      await  _getQuestions();
    }
    log("_questionList");
    return _questionList;
  }



  Future<String> addQuestion(QuestionModel model, List<XFile> images) async {
    _questionList.questions.add (await _questionService
        .addQuestion( model, images)
        .whenComplete(() async {
      log("TRUE111111111111111111111111111");
      notifyListeners();
    }));
    return "Done";
  }

  Future<void> _getQuestions() async {
    log("get question done");
    _questionList= await _questionService.getQuestions();
  }
}