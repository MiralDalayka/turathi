import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/utils/shared.dart';

class CommentModel {
  String? id;
  DateTime? date;
  String? commentTxt;
  String? writerName;
  int? writtenByExpert;
  String? placeId;
  String? questionId;

  CommentModel(
      {
        required this.commentTxt,
        this.placeId,
        this.questionId}){
          id=uuid.v4();
          date = DateTime.now();
          writerName = user.name;
          writtenByExpert = user.role == UsersRole.expert ? 1 : 0;

  }

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    commentTxt = json['commentTxt'];
    writerName = json['writerName'];
    writtenByExpert = json['writtenByExpert'];
    placeId = json['placeId'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['commentTxt'] = this.commentTxt;
    data['writerName'] = this.writerName;
    data['writtenByExpert'] = this.writtenByExpert;
    data['placeId'] = this.placeId;
    data['questionId'] = this.questionId;
    return data;
  }
}
class CommentList {
  List<CommentModel> comments;

  CommentList({required this.comments});

  factory CommentList.fromJson(List<dynamic> data) {

    List<CommentModel> temp = [];
    temp = data.map((item) {
      return CommentModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return CommentList(comments: temp);
  }
}
