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
