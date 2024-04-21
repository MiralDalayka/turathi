import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    Key? key,
    this.width = 300,
    this.aspectRatio = 0.7,
    required this.onPress,
    required this.placeModel,
    required this.onFavoriteChanged,
  }) : super(key: key);

  final double width, aspectRatio;
  final PlaceModel placeModel;
  final VoidCallback onPress;
  final Function(bool isFavourite) onFavoriteChanged;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    // isFavourite = widget.placeModel.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.placeModel.images![0],
                      fit: BoxFit.fill,
                      color: Colors.black.withOpacity(0.15),
                      colorBlendMode: BlendMode.darken,
                    )),
                Positioned(
                  bottom: LayoutManager.widthNHeight0(context, 0)*0.045,
                  left: LayoutManager.widthNHeight0(context, 0)*0.04,
                  child: Text(
                    widget.placeModel.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: ThemeManager.second,
                      fontFamily: ThemeManager.fontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: LayoutManager.widthNHeight0(context, 0)*0.017
                    ),
                  ),
                ),
                Positioned(
                  bottom:  LayoutManager.widthNHeight0(context, 0)*0.001,
                  right:  LayoutManager.widthNHeight0(context, 1)*0.0002,
                  child: IconButton(
                    //BACK
                    icon: Icon(Icons.add),
                    // icon: Icon(
                    //   widget.placeModel.isFavourite!
                    //       ? Icons.favorite
                    //       : Icons.favorite_border_outlined,
                    //   size: LayoutManager.widthNHeight0(context, 1) * 0.065,
                    //   color: widget.placeModel.isFavourite!
                    //       ? const Color(0xFFA74040)
                    //       : ThemeManager.second,
                    // ),
                    onPressed: () {
                      setState(() {
                        // widget.placeModel.isFavourite =
                        //     !widget.placeModel.isFavourite!;
                        // widget.onFavoriteChanged(widget.placeModel.isFavourite!);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
