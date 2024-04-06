import 'dart:developer';


class TestModel {
String? title;
int? num;

  TestModel(
      {

      required  this.title,
        required  this.num,

       });

  TestModel.fromJson(Map<String, dynamic> json) {

    title = json['title'];
    num = json['num'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['num'] = this.num;

    return data;
  }
}


class TestList {
  List<TestModel> tests;

  TestList({required this.tests});

  factory TestList.fromJson(List<dynamic> data) {
    log("I'm In TestList Factory");
    //1. temp list
    List<TestModel> tempTests = [];
    tempTests = data.map((item) {
      return TestModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return TestList(tests: tempTests);
  }
}