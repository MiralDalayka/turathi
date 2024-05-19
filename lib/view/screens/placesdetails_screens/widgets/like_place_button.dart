import 'package:flutter/material.dart';

import '../../../../core/models/place_model.dart';
import '../../../../utils/layout_manager.dart';
import '../../../../utils/shared.dart';
import '../../../../utils/theme_manager.dart';

class LikeButton extends StatefulWidget {
  final PlaceModel placeModel;
  final Function onLike;

  LikeButton({required this.placeModel, required this.onLike});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.onLike();
        });
      },
      icon: SizedBox(
        width: LayoutManager.widthNHeight0(context, 1) * 0.045,
        height: LayoutManager.widthNHeight0(context, 1) * 0.045,
        child: Image.asset(
          widget.placeModel.likesList!.contains(sharedUser.id)
              ? "assets/images/img_png/like_filled.png"
              : "assets/images/img_png/like.png",
          color: ThemeManager.primary,
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}