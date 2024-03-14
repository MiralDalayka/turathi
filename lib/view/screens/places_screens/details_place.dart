import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/theme_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.placeModel}) : super(key: key);
 
  final PlaceModel placeModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Place",style: TextStyle(fontSize: 20,color: ThemeManager.primary),),
    );
  }
}
