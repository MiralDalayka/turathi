import 'package:image_picker/image_picker.dart';

// Future<List<XFile>> pickImages() async{
//   final picker = ImagePicker();
//   return await picker.pickMultiImage();

// }

List<XFile> images = [];
Future<List<XFile>> pickImages() async {
  final picker = ImagePicker();
  final List<XFile>? pickedImages = await picker.pickMultiImage();
  if (pickedImages != null) {

   
    if (images.length + pickedImages.length <= 4) { // Limit the number of select images to 4
      images.addAll(pickedImages);
    } else {
     
      images.addAll(pickedImages.sublist(0, 4 - images.length)); // If exceeding 4 then only add up to 4 images
    }
    return images;
  }
  return [];
}
