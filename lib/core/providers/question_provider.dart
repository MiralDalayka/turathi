import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/core/services/question_service.dart';



class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();

  Future<String> addQuestion(QuestionModel model, List<XFile> images) async {
    String msg = (await _questionService.addQuestion(model,images).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<QuestionList> getQuestions() async {
    return await _questionService.getQuestions();
  }
}