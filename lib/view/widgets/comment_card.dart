import 'package:flutter/material.dart';
import 'package:turathi/core/models/comment_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/comment_circle.dart';

class CommentCard extends StatelessWidget {
  final CommentModel commentModel;

  const CommentCard({
    Key? key, 
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CommentInfo(text: "text", place: commentModel.writerName),
          SizedBox(
            height: LayoutManager.widthNHeight0(context, 0) * 0.02,
          ),
          Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}

class CommentInfo extends StatelessWidget {
  final String text;
  final String? place;

  const CommentInfo({
    Key? key, 
    required this.text, 
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: LayoutManager.widthNHeight0(context, 0) * 0.03,
        ),
        Row(
          children: [
            CircleTextWidget(),
            SizedBox(
              width: LayoutManager.widthNHeight0(context, 1) * 0.015,
            ),
            Text(
              place ?? '',
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.textColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(
          height: LayoutManager.widthNHeight0(context, 0) * 0.02,
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.textColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
