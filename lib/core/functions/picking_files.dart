import 'package:image_picker/image_picker.dart';

Future<List<XFile>> pickImages() async{
  final picker = ImagePicker();
  return await picker.pickMultiImage();

}