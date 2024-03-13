import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:turathi/core/models/comment_model.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';

class CommentDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();

  CommentDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child:  Text('Cancel',style: ThemeManager.textStyle,),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    log(commentController.text);
                    //BACK
                    //write this code in the cont
                    //create a comment model
                    //  CommentModel(commentTxt: commentController.text,writerName: userModel,date: DateTime.now(),writtenByExpert: userModelExpert)
                    // state management
                    Navigator.of(context).pop();
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
