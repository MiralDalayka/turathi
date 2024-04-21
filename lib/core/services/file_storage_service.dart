import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class FilesStorageService {

   final FirebaseStorage _storageInstance =
        FirebaseStorage.instanceFor(bucket: 'turathi-96897.appspot.com');

  Future<String> addFile(File file) async {
    // File file = File(xFile.path);
    var fileName = basename(file.path);
    Reference reference = _storageInstance.ref().child("certificateFiles/$fileName");
/////
    UploadTask uploadTask = reference.putFile(file);

    String url = await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
    return url;
  }



  Future<void> uploadImages(
      {required String imageType,required String folderName, required List<XFile> pickedImages}) async {


    if (pickedImages != null) {
      for (var image in pickedImages) {
        XFile file = XFile(image.path);
        String fileName = basename(image.path);
        Reference storageReference =
            _storageInstance.ref().child('$imageType/$folderName/$fileName');
        await storageReference.putFile(File(file.path));
      }
    } else {
      log('No data');
    }
  }

  Future<List<String>> getImages({required String imageType,required String folderName}) async {
    List<String> fileUrls = [];

    try {
      // Get reference to the folder
      Reference folderRef =
          _storageInstance.ref().child('$imageType/$folderName');

      ListResult result = await folderRef.listAll();

      await Future.forEach(result.items, (Reference ref) async {
        String url = await ref.getDownloadURL();
        fileUrls.add(url);
      });
    } catch (e) {
      log('Error retrieving files: $e');
    }

    return fileUrls;
  }
}
