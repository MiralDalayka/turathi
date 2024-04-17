import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/services/google_map_add_event.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';

import '../../../utils/theme_manager.dart';
import '../../widgets/custom_text_form.dart';

class AddNewEvent extends StatefulWidget {
  const AddNewEvent({super.key});

  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final disc = TextEditingController();
  final address = TextEditingController();
  final ticketPrice = TextEditingController();
  final creatorName = TextEditingController();

  //date
  bool mapScreenOpened = false;
  XFile? image;
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

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
          'Add Event',
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
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: name,
                  hintText: 'Enter event name',
                  labelText: 'Name',
                ),
                TextFormFieldWidget(
                  controller: address,
                  hintText: 'Enter event address in your words',
                  labelText: 'Address',
                ),
                TextFormFieldWidget(
                  controller: ticketPrice,
                  hintText: 'Enter event ticket price, 0 for free events',
                  labelText: 'Ticket Price',
                ),
                TextFormFieldWidget(
                  controller: creatorName,
                  hintText: 'Enter event creator name',
                  labelText: 'Creator Name',
                ),
                TextFormFieldWidget(
                  hintText: 'Enter event description',
                  labelText: 'Description',
                  maxLine: 3,
                  controller: disc,
                ),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          mapScreenOpened = true;
                        });
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEventMap(),
                          ),
                        );
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Location',
                        style: ThemeManager.textStyle.copyWith(
                          color: mapScreenOpened &&
                                  addEventLocatonLat != 0 &&
                                  addEventLocatonLog != 0
                              ? Colors.grey
                              : (addEventLocatonLat != 0 &&
                                      addEventLocatonLog != 0)
                                  ? Colors.grey
                                  : ThemeManager.primary,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickDate();
                      },
                      style: ThemeManager.buttonStyle,
                      child: Text(
                        'Select date',
                        style: ThemeManager.textStyle
                            .copyWith(color: ThemeManager.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate()) {
                        //call controller
                        name.clear();
                        disc.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Add Event Successfully")));
                      } else {
                        log('add Event failed');
                      }
                    });
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Event',
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
