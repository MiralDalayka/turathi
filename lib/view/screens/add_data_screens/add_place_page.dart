import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/functions/files_stoage.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/providers/place_provider.dart';

import '../../../utils/theme_manager.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/ui_helper.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final disc = TextEditingController();
  final ImageStorageService _fileService = ImageStorageService();
  // XFile? image;
  // Future<void> _pickImage() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       image = pickedImage;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // var placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Place',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: name,
                  hintText: 'Enter Place Name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  hintText: 'Enter Place Description',
                  labelText: 'Description',
                  maxLine: 5,
                  controller: disc,
                ),
                // if (image != null) Image.file(File(image!.path)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ElevatedButton(
                    //   onPressed: _fileService.pickImages,
                    //   style: ThemeManager.buttonStyle,
                    //   child: Text(
                    //     'Pick Image',
                    //     style: ThemeManager.textStyle
                    //         .copyWith(color: ThemeManager.primary),
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (formKey.currentState!.validate()) {
                            // if (image == null) {
                            //   snackBarFunction(
                            //       msg: "Pick Image Please", context: context);
                            // } else {
                             { //call controller
                              name.clear();
                              disc.clear();
                              snackBarFunction(
                                  msg: "Place Added Successfully",
                                  context: context);
                              //BACK
                              // placeProvider.addPlace(PlaceModel(id: '211'));
                              // Navigator.of(context).pushNamed(placeDetailsRoute,arguments: );
                              Navigator.of(context).pop();
                            }
                          } else {
                            log('add place failed');
                          }
                        });
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Add Place',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}