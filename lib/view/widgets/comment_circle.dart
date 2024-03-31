import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

class CircleTextWidget extends StatelessWidget {
  final String text;

  const CircleTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initial = text.isNotEmpty ? text[0].toUpperCase() : '';

    return Container(
      width: LayoutManager.widthNHeight0(context, 1) * 0.1,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ThemeManager.primary,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
