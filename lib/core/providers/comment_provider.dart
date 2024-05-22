import 'package:flutter/cupertino.dart';
import '../data_layer.dart';



class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();

  Future<String> addComment(CommentModel model) async {
    String msg = (await _commentService.addComment(model).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

  Future<CommentList> getQuestionComments(String questionId) async {
    return await _commentService.getQuestionComments(questionId);
  }

  Future<CommentList> getPlaceComments(String placeId) async {
    return await _commentService.getPlaceComments(placeId);
  }
}