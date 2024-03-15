import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/community_screens/community_screen.dart';

import '../../../core/models/comment_model.dart';
import '../../../utils/layout_manager.dart';
import '../../widgets/add_button.dart';
import '../../widgets/back_arrow_button.dart';
import 'widgets/comment_box.dart';
import 'widgets/comment_dialog.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key, required this.question});

  final QuestionModel question;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    var height = LayoutManager.widthNHeight0(context, 0) * 0.35;
    //cotroller
    comments.sort((a, b) => b.writtenByExpert!.compareTo(a.writtenByExpert!));
    double left = 15;
    double icon_left=10;
    return Stack(
      children: <Widget>[

        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.network(
              color: Colors.black.withOpacity(0.2),
            colorBlendMode: BlendMode.darken,
            widget.question.imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: height - 120,
          left: left,
          child: Text(
            widget.question.title!,
            style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.04,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
          top: height - 70,
          left: left,
          child: Text(
            widget.question.writer!,
            style: TextStyle(
                // fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.02,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
            top: height - 20,
            bottom: 0,
            child: Container(
              height: LayoutManager.widthNHeight0(context, 0),
              width: LayoutManager.widthNHeight0(context, 1),
              decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      widget.question.questionTxt!,
                      style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: ThemeManager.textColor,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CommentBox(
                              comment: comments[index],
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(),
                          itemCount: comments.length),
                    )
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 20,
          right: 20,
          child: AddButton(onPressed: (){
            //controller //BACK
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CommentDialog();
              },
            );
          }),
        ),
        Positioned(
            top: 25,
            left: icon_left,
            child: BackArrowButton(color: Colors.white,)),
      ],
    );
  }
}

var txt =
    "Changed 1 dependency! 7 packages have newer versions incompatible with dependency constraints. Try `flutter pub outdated` for more information. ";
List<CommentModel> comments = [
  CommentModel(
      id: '1',
      commentTxt: txt,
      date: DateTime.now(),
      writerName: 'Alaa',
      writtenByExpert: 1),
  CommentModel(
      id: '1',
      commentTxt: txt,
      date: DateTime.now(),
      writerName: 'Alaa',
      writtenByExpert: 0),
  CommentModel(
      id: '1',
      commentTxt: txt,
      date: DateTime.now(),
      writerName: 'Alaa',
      writtenByExpert: 1),
  CommentModel(
      id: '1',
      commentTxt: txt,
      date: DateTime.now(),
      writerName: 'Alaa',
      writtenByExpert: 0),
];
