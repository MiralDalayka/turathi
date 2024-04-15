import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/core/services/question_service.dart';



class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();

  Future<String> addQuestion(QuestionModel model) async {
    String msg = (await _questionService.addQuestion(model).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<QuestionList> getQuestions() async {
    return await _questionService.getQuestions();
  }
}