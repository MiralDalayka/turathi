import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';

class QuestionDialog extends StatefulWidget {
  const QuestionDialog({super.key});

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController questionController = TextEditingController();
   late XFile image ;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = pickedImage!;
    });
  }

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
              'Write a question', // Change text here
              style: ThemeManager.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              controller: questionController,
              decoration: InputDecoration(
                hintText: 'Ask your question here...',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary)),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            image != null
                ? Image.file(File(image.path))
                : const Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
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
                    log(questionController.text);
                    // Write this code in the context to save the question
                    // Create a question model
                    // QuestionModel(questionTxt: questionController.text, writerName: userModel, date: DateTime.now(), writtenByExpert: userModelExpert)
                    // State management
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
