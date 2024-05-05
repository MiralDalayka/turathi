import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/comment_model.dart';
import 'package:turathi/core/providers/comment_provider.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';

class CommentDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final String questionId;

  CommentDialog({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    CommentProvider provider = Provider.of<CommentProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        color: ThemeManager.second,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Write a comment',
              style: ThemeManager.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Share your ideas here...',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: ThemeManager.textStyle,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    log(commentController.text);
                    provider
                        .addComment(CommentModel(
                            commentTxt: commentController.text,
                            questionId: questionId))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  child: Text(
                    'Save',
                    style: ThemeManager.textStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
