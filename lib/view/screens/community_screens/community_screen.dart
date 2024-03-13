import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';

import '../../../core/models/question_model.dart';
import '../../../utils/layoutManager.dart';
import '../../widgets/question_box.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.06,
        title: Text(
          "Community",
          style: TextStyle(
              fontFamily: ThemeManager.fontFamily,
              color: ThemeManager.primary,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ThemeManager.primary,
            ),
            onPressed: () {
              //back
            },
            iconSize: LayoutManager.widthNHeight0(context, 0) * 0.034,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: LayoutManager.widthNHeight0(context, 0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return QuestionBox(
                  question: questions[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount: questions.length),
        ),
      ),
    );
  }
}

var txt = "Nunc dictum facilisis lectus, a cursus tellus vulputate id. In neque lectus, congue dictum accumsan eget, congue venenatis leo. Vestibulum porta quis risus vitae finibus.";
List<QuestionModel> questions = [
  QuestionModel(
      imageUrl:
      'https://media.istockphoto.com/id/453238697/photo/vintage-pocket-watch.jpg?s=612x612&w=0&k=20&c=siL4gXxZilIMv2aAeDFsjJAtI5FZz-sazMK4ckWA7oY=',
      title: 'Title',
      writer: 'Alla',
      id: '1',questionTxt: txt),  QuestionModel(
      imageUrl:
      'https://media.istockphoto.com/id/453238697/photo/vintage-pocket-watch.jpg?s=612x612&w=0&k=20&c=siL4gXxZilIMv2aAeDFsjJAtI5FZz-sazMK4ckWA7oY=',
      title: 'Title',
      writer: 'Alla',
      id: '1',questionTxt: txt),  QuestionModel(
      imageUrl:
      'https://media.istockphoto.com/id/453238697/photo/vintage-pocket-watch.jpg?s=612x612&w=0&k=20&c=siL4gXxZilIMv2aAeDFsjJAtI5FZz-sazMK4ckWA7oY=',
      title: 'Title',
      writer: 'Alla',
      id: '1',questionTxt: txt),  QuestionModel(
      imageUrl:
      'https://media.istockphoto.com/id/453238697/photo/vintage-pocket-watch.jpg?s=612x612&w=0&k=20&c=siL4gXxZilIMv2aAeDFsjJAtI5FZz-sazMK4ckWA7oY=',
      title: 'Title',
      writer: 'Alla',
      id: '1',questionTxt: txt),  QuestionModel(
      imageUrl:
      'https://media.istockphoto.com/id/453238697/photo/vintage-pocket-watch.jpg?s=612x612&w=0&k=20&c=siL4gXxZilIMv2aAeDFsjJAtI5FZz-sazMK4ckWA7oY=',
      title: 'Title',
      writer: 'Alla',
      id: '1',questionTxt: txt),
];
