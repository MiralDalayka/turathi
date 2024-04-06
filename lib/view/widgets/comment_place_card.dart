import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turathi/core/models/comment_model.dart';
import 'package:turathi/core/models/comment_place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/comment_circle.dart';

class CommentCard extends StatelessWidget {
  final PlaceCommentModel commentModel;

  const CommentCard({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CommentInfo(
              text: commentModel.commentTxt,
              writer: commentModel.writerName,
              date: commentModel.date),
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
  final String? text;
  final String? writer;
  final DateTime? date;

  const CommentInfo({
    Key? key,
    required this.text,
    required this.writer,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: LayoutManager.widthNHeight0(context, 0) * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
             CircleTextWidget(text: writer ?? ''),
            SizedBox(width: LayoutManager.widthNHeight0(context, 1) * 0.015),
            Text(
              writer ?? '',
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.textColor,
                fontSize: 15,
              ),
            ),
           ],),
          
            Text(
              _getDisplayTime(date),
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.textColor,
                fontSize: 12,
              ),
            ),
            // Expanded(child: SizedBox()), 
          ],
        ),
        SizedBox(
          height: LayoutManager.widthNHeight0(context, 0) * 0.02,
        ),
        Text(
          text ?? '',
          style: TextStyle(
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.textColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String _getDisplayTime(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      return '${DateFormat.Hm().format(date)}   ';
    }
  }
}