import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import '../../../view_layer.dart';
class QuestionDialog extends StatefulWidget {
  const QuestionDialog({Key? key}) : super(key: key);

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController text = TextEditingController();
  final TextEditingController title = TextEditingController();

  List<XFile>? images;

  String txt = '';

  @override
  Widget build(BuildContext context) {
    QuestionProvider questionProvider = Provider.of<QuestionProvider>(context);
    return Dialog(
      backgroundColor: ThemeManager.second,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0), // make it circular
      ),
      child: SingleChildScrollView(
        child: Container(
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
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 5,
                controller: text,
                decoration: InputDecoration(
                  hintText: 'Ask your question here...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  images = await pickImages();
                },
                style: ThemeManager.buttonStyle,
                child: Text(
                  'Pick Image',
                  style: ThemeManager.textStyle
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  txt,
                  style: ThemeManager.textStyle.copyWith(
                      fontWeight: FontWeight.w200,
                      color: Colors.red,
                      fontSize: 10),
                ),
              ),
              const SizedBox(height: 10),
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
                    onPressed: () async {
                      if (text.text.isNotEmpty &&
                          title.text.isNotEmpty &&
                          images != null) {
                        setState(() {
                          txt = "";
                        });
                        await questionProvider
                            .addQuestion(
                                QuestionModel(
                                    title: title.text, questionTxt: text.text),
                                images!)
                            .whenComplete(() => Navigator.of(context).pop());
                      } else {
                        setState(() {
                          txt = "*All field are required";
                        });
                        log('add Question failed');
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
      ),
    );
  }
}
