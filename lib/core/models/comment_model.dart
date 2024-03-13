class CommentModel {
  String? id;
  DateTime? date;
  String? commentTxt;
  String? writerName;
  int? writtenByExpert;

  CommentModel(
      { this.id,
         this.date,
         this.commentTxt,
         this.writerName,
         this.writtenByExpert});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    commentTxt = json['commentTxt'];
    writerName = json['writerName'];
    writtenByExpert = json['writtenByExpert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['commentTxt'] = this.commentTxt;
    data['writerName'] = this.writerName;
    data['writtenByExpert'] = this.writtenByExpert;
    return data;
  }
}
