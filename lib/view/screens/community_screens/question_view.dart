import 'package:flutter/material.dart';
import '../../../core/models/comment_model.dart';
import '../../../core/models/question_model.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/theme_manager.dart';
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
    //controller
    // comments.sort((a, b) => b.writtenByExpert!.compareTo(a.writtenByExpert!));
    double left = 15;
    double iconLeft = 10;
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
                    const SizedBox(
                      height: 10,
                    ),
                    // Expanded(
                    //   child: ListView.separated(
                    //       itemBuilder: (context, index) {
                    //         return CommentBox(
                    //           comment: comments[index],
                    //         );
                    //       },
                    //       separatorBuilder: (context, index) =>
                    //           const SizedBox(),
                    //       itemCount: comments.length),
                    // )
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 20,
          right: 20,
          child: AddButton(onPressed: () {
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
            left: iconLeft,
            child: const BackArrowButton(
              color: Colors.white,
            )),
      ],
    );
  }
}

