import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/theme_manager.dart';
import '../../widgets/custom_text_form.dart';

class ReportPlace extends StatefulWidget {
  const ReportPlace({super.key, required this.placeID});
final String placeID;
  @override
  State<ReportPlace> createState() => _ReportPlaceState();

}

class _ReportPlaceState extends State<ReportPlace> {
  final formKey = GlobalKey<FormState>();
  final reasons = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Write a Report',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldWidget(
                  hintText: 'Enter Report Description',
                  labelText: '',
                  maxLine: 15,
                  controller: reasons,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate()) {
                        //call controller
                        reasons.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Report Added Successfully")));
                        Navigator.pop(context);
                      } else {
                        log('add report failed');
                      }
                    });
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Report',
                    style: ThemeManager.textStyle
                        .copyWith(color: ThemeManager.primary),
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
