import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FileStorageService {

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> addFile(XFile xFile) async{

    File file = File(xFile.path);
    var fileName = basename(xFile.path);
    Reference reference = _storage.ref().child("certificateFiles/${fileName}");

    UploadTask uploadTask = reference.putFile(file);

    String url = await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
    return url;
  }
}

