import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:turathi/tests/testView.dart';

import '../core/services/file_storage_service.dart';

class ImageUploader extends StatelessWidget {




  @override
  FilesStorageService service =FilesStorageService();
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: (){
            service.uploadImages('file44');
          },
          child: Text('Upload Image'),
        ),

        ElevatedButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const TestView()));
          },
          child: Text('show Image'),
        ),
      ],
    );
  }
}
