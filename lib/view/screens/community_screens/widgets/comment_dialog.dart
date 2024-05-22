import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import '../../../view_layer.dart';

class CommentDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final String questionId;

  CommentDialog({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    CommentProvider provider = Provider.of<CommentProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
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
                    if (commentController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return showCustomAlertDialog(
                              context, "Please write a comment before saving");
                        },
                      );
                    } else {
                      log(commentController.text);
                      provider
                          .addComment(CommentModel(
                              commentTxt: commentController.text,
                              questionId: questionId))
                          .whenComplete(() => Navigator.of(context).pop());
                    }
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
