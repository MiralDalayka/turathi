import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';

class TextFormFieldWidget extends StatelessWidget {
   const TextFormFieldWidget({super.key, required this.labelText, required this.hintText,this.maxLine=1, required this.controller});
final String labelText;
  final String hintText;
  final int maxLine;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,

        maxLines: maxLine,
        validator: (value) {
          if (value!.isEmpty) {
            return '* Required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: ThemeManager.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          hintText: hintText,
          filled: true,
          fillColor: ThemeManager.second,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
