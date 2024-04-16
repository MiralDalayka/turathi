import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorageService {

  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'turathi-96897.appspot.com');

  Future<void> uploadImage(folderName) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get file path using Xfile
      XFile file = XFile(pickedFile.path);

      // Upload file to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      _storage.ref().child('placesImages/$folderName/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(file.path));

      await uploadTask.whenComplete(() => print('File Uploaded'));
    } else {
      print('No image selected.');
    }
  }
  // final FirebaseStorage _instance = FirebaseStorage.instance;
  // List<XFile>? images;
  // String firebasePath = 'placesImages/file1';
  // final List<String> _imagesUrl = [];
  //
  // Future<void> _uploadImages(String fileName) async {
  //   for (var image in images!) {
  //     Reference ref = FirebaseStorage.instance
  //         .ref()
  //         .child('/PlacesImages')
  //         .child('$fileName/$image');
  //     ref.putFile(File(image.path));
  //
  //   }
  // }
  //
  // Future<List<String>> getImages() async {
  //   log('1');
  //
  //   log(_imagesUrl.toString());
  //   return _imagesUrl;
  // }
  //
  // Future<void> pickImages() async {
  //   String fileName = 'file4';
  //   images = await ImagePicker().pickMultiImage();
  //   if (images != null) {
  //     _uploadImages(fileName);
  //   } else {
  //     log("pickImages ERROR");
  //   }
  // }
}
