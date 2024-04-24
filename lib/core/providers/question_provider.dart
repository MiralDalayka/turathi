import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/core/services/question_service.dart';



class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();
 QuestionList _questionList=QuestionList(questions: []);

  Future<QuestionList> get questionList  async{
    if(_questionList.questions.isEmpty){
    await  _getQuestions();
    }
    return _questionList;
  }

  Future<String> addQuestion(QuestionModel model, List<XFile> images) async {
    String msg = (await _questionService.addQuestion(model,images).whenComplete(() {
      _getQuestions();
      notifyListeners();

    }));
    return msg;
  }

  Future<void> _getQuestions() async {
    log("get question done");
    _questionList= await _questionService.getQuestions();
  }
}