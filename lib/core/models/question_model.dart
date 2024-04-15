class QuestionModel {
  String? id;
  String? imageUrl;
  String? title;
  String? questionTxt;
  String? writer;

  QuestionModel(
      {this.id, this.title, this.questionTxt, this.writer, this.imageUrl});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    questionTxt = json['questionTxt'];
    writer = json['writer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['questionTxt'] = this.questionTxt;
    data['writer'] = this.writer;
    return data;
  }
}
class QuestionList {
  List<QuestionModel> questions;

  QuestionList({required this.questions});

  factory QuestionList.fromJson(List<dynamic> data) {

    List<QuestionModel> temp = [];
    temp = data.map((item) {
      return QuestionModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return QuestionList(questions: temp);
  }
}
