import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/utils/shared.dart';


class FilesStorageService {

   final FirebaseStorage _storageInstance =
        FirebaseStorage.instanceFor(bucket: 'turathi-96897.appspot.com');

  Future<String> addFile(File file) async {
    Reference reference = _storageInstance.ref().child("certificateFiles/${sharedUser.id}");
    UploadTask uploadTask = reference.putFile(file);

    String url = await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
    return url;
  }



  Future<List<String>> uploadImages(
      {required String imageType,required String folderName, required List<XFile> pickedImages}) async {

List<String> urlList =[];
    if (pickedImages != null) {
      for (var image in pickedImages) {
        XFile file = XFile(image.path);
        String fileName = basename(image.path);
        Reference storageReference =
            _storageInstance.ref().child('$imageType/$folderName/$fileName');
        await storageReference.putFile(File(file.path)).then((p0) async {
          urlList.add(await p0.ref.getDownloadURL());
          log("Images");
        });



      }
    } else {
      log('No data');
    }
    return urlList;
  }

  Future<List<String>> getImages({required String imageType,required String folderName}) async {
    List<String> fileUrls = [];

    try {
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
   Future<void> deleteFile({required String userId}) async {
       Reference reference = _storageInstance.ref().child("certificateFiles/${userId}");
       reference.delete().whenComplete(() {
         log("certificate deleted successfully");
       }
       );
   }
}
