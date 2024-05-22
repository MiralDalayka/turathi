import 'package:flutter/cupertino.dart';
import '../data_layer.dart';

// This Provider class To Manage comments
class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();

// Method to add a new comment
  Future<String> addComment(CommentModel model) async {
    String msg = (await _commentService.addComment(model).whenComplete(() {
      notifyListeners();
    }));
    return msg;
  }

// Method to fetch comments associated with a specific question
  Future<CommentList> getQuestionComments(String questionId) async {
    return await _commentService.getQuestionComments(questionId);
  }

 // This is to fetch comments associated with a specific question
  Future<CommentList> getPlaceComments(String placeId) async {
    return await _commentService.getPlaceComments(placeId);
  }
}