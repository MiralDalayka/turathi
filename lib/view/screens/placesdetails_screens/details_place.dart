import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';
import 'package:turathi/view/screens/community_screens/widgets/comment_box.dart';
import 'package:turathi/view/screens/community_screens/widgets/comment_dialog.dart';
import 'package:turathi/view/widgets/add_button.dart';
import 'package:turathi/view/widgets/back_arrow_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.placeModel}) : super(key: key);
 
  final PlaceModel placeModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedImage = 0;

  Key? get key => null;

  @override
  Widget build(BuildContext context) {
    var height = LayoutManager.widthNHeight0(context, 0) * 0.35;
double left = 15;
    return Stack(
      children: <Widget>[

        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(
            widget.placeModel.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: height - 120,
          left: left,
          child: Text(
           " widget.question.title!,",
            style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.04,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
          top: height - 70,
          left: left,
          child: Text(
         "   widget.question.writer!,",
            style: TextStyle(
                // fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.02,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
            top: height - 20,
            bottom: 0,
            child: Container(
              height: LayoutManager.widthNHeight0(context, 0),
              width: LayoutManager.widthNHeight0(context, 1),
              decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                   
                  ],
                ),
              ),
            )),
      
        Positioned(
            top: 10,
            left: 15,
            child: BackArrowButton(color: Colors.white,)),
      ],
    );
  }
}