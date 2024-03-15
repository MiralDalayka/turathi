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
    isFavourite = widget.placeModel.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            widget.placeModel.images[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: LayoutManager.widthNHeight0(context, 0) * 0.18,
                          left: LayoutManager.widthNHeight0(context, 1) * 0.088,
                          child: Text(
                            widget.placeModel.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily:ThemeManager.fontFamily,
                              color: ThemeManager.second,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: LayoutManager.widthNHeight0(context, 0) * 0.2,
                          left: LayoutManager.widthNHeight0(context, 1) * 0.33,
                          child: IconButton(
                            icon: 
                            // Icon(
                            //   Icons.favorite,
                            //   size: LayoutManager.widthNHeight0(context, 1) * 0.06,
                            //   color: widget.placeModel.isFavourite ? const Color(0xFFA74040) : const Color(0xff263238),
                            // ),
                            Icon(
                              widget.placeModel.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: LayoutManager.widthNHeight0(context, 1) *
                                  0.065,
                              color: widget.placeModel.isFavourite
                                  ? const Color(0xFFA74040)
                                  : ThemeManager.second,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.placeModel.isFavourite = !widget.placeModel.isFavourite;
                                widget.onFavoriteChanged(widget.placeModel.isFavourite);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
