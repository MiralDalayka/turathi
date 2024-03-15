import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.of(context).pop();
    }, icon:Icon( Icons.arrow_back_sharp,color:color,size: 25,));
  }
}
