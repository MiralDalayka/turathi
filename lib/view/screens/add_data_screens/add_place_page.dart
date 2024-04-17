import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/services/google_map_addplace.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';

import '../../../utils/theme_manager.dart';
import '../../widgets/custom_text_form.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final disc = TextEditingController();
  final address = TextEditingController();
  final creatorName = TextEditingController();

  XFile? image;
  bool mapScreenOpened = false;
  DateTime selectedDate = DateTime.now();

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        centerTitle: true,
        title: Text(
          'Add Place',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: name,
                  hintText: 'Enter place name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: 'Enter place address in your words',
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  controller: creatorName,
                  hintText: 'Enter place creator name',
                  labelText: 'Creator Name',
                ),
                TextFormFieldWidget(
                  hintText: 'Enter place description',
                  labelText: 'Description',
                  maxLine: 3,
                  controller: disc,
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Pick Image',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    ),
                    if (image != null) Image.file(File(image!.path)),

                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          mapScreenOpened = true;
                        });
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPlaceMap(),
                          ),
                        );
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Location',
                        style: ThemeManager.textStyle.copyWith(
                          color: ThemeManager.primary
                          // mapScreenOpened &&
                          //         addPlaceLocatonLat != 0 &&
                          //         addPlaceLocatonLong != 0
                          //     ? Colors.grey
                          //     : (addPlaceLocatonLat != 0 &&
                          //             addPlaceLocatonLong != 0)
                          //         ? Colors.grey
                          //         : ThemeManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutManager.widthNHeight0(context, 1) * 0.1,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate() &&
                          addPlaceLocatonLat != 0 &&
                          addPlaceLocatonLat != 0) {
                        ///check the images not empty

                        name.clear();
                        disc.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Place Successfully")));
                      } else {
                        log('add place failed');
                      }
                    });
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Place',
                    style: ThemeManager.textStyle
                        .copyWith(color: ThemeManager.textColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
