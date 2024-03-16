
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';

class SmallImage extends StatelessWidget {
  const SmallImage({
    super.key,
    required this.isSelected,
    required this.press,
    required this.image,
  });

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedContainer(
        duration: Duration.zero,
        margin: const EdgeInsets.only(right: 0),
        padding: const EdgeInsets.all(3),
        height: 42,
        width: 42,
      decoration: BoxDecoration(
          color: ThemeManager.second.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ThemeManager.primary.withOpacity(isSelected ? 1 : 0),
            width: 1.8, 
          ),
        ),
        child: Image.asset(
          image,
          fit: BoxFit.fill, 
        ),
      )
    );
  }
}
