import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/core/services/google_map_addplace.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';

import '../../../core/functions/picking_files.dart';
import '../../../core/services/file_storage_service.dart';
import '../../../core/services/place_service.dart';
import '../../../utils/theme_manager.dart';
import '../../widgets/custom_text_form.dart';

class EditPlace extends StatefulWidget {
  const EditPlace({super.key,required this.placeModel});
  final PlaceModel placeModel;

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  final formKey = GlobalKey<FormState>();
  XFile? image;
  bool mapScreenOpened = false;
  DateTime selectedDate = DateTime.now();
  List<double>? data;
  List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController(text: widget.placeModel.title);
    final disc = TextEditingController(text: widget.placeModel.description);
    final address = TextEditingController(text: widget.placeModel.address);
    final status = TextEditingController(text: widget.placeModel.status);
   

    final PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);
    
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
                  controller: title,
                  hintText: 'Edit place name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: 'Edit place address in your words',
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  hintText: 'Edit place description',
                  labelText: 'Description',
                  maxLine: 3,
                  controller: disc,
                ),
                TextFormFieldWidget(
                  controller: status,
                  hintText: 'Edit place status',
                  labelText: 'Status',
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
                      onPressed: () async {
                        images = await pickImages();
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Pick Image',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final temp =   await   Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => AddPlaceMap(),
                             ),
                           );
                        setState(() {
                          mapScreenOpened = true;
                     data = temp;
                        });


                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Location',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary
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
                  onPressed: () async {

                    if (formKey.currentState!.validate() && images != null &&data!.isNotEmpty) {
                      placesProvider.updatePlace(
                         model:  PlaceModel(
                            title: title.text,
                            description: disc.text,
                            address: address.text,
                            latitude: data![0],
                            longitude: data![1],
                           status: status.text
                          ),
                        images:   images!);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Place Updated Successfully")));
                      Navigator.pop(context);
                    } else {
                      log('add place failed');
                    }
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
