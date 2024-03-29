
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/theme_manager.dart';


class RequestToBeExpert extends StatefulWidget {
  const RequestToBeExpert({super.key});

  @override
  State<RequestToBeExpert> createState() => _RequestToBeExpertState();

}

class _RequestToBeExpertState extends State<RequestToBeExpert> {
File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Request To Be Expert',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
          onPressed: () {
            _pickFile();
        },
          style: ThemeManager.buttonStyle,
          child: Text(
            'Upload Certificate',
            style: ThemeManager.textStyle
                .copyWith(color: ThemeManager.primary),
          ),
        ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {
              // back
            },
            style: ThemeManager.buttonStyle,
            child: Text(
              'Request',
              style: ThemeManager.textStyle
                  .copyWith(color: ThemeManager.primary),
            ),
          )
        ],
      ),
    );
  }

Future<void> _pickFile() async{
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.files.single.path!);
      });
    }

  }
}
