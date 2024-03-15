import 'dart:ui';

import 'package:flutter/material.dart';

class PlaceModel {
  final String ussid; // user id
  final String id;
  final String title, description, status, location;
  final List<String> commentsPlace;
  final List<dynamic> images;
  final int like, disLike;
  bool isFavourite, isPopular;
  double long, late;

  PlaceModel({
    this.ussid = "",
    required this.images,
    required this.commentsPlace,
    required this.title,
    required this.id,
    required this.description,
    required this.status,
    required this.location,
    this.like = 0,
    this.disLike = 0,
    this.isFavourite = false,
    this.isPopular = false,
    this.long = 1,
    this.late = 1,
  });

  void toggleFavorite() {
    isFavourite = !isFavourite;
  }
}

List<PlaceModel> demoPlaces = [
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "1",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/Dukes.png",
      "assets/images/img_png/Dukes.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "2",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "3",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "4",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "5",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "6",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    long: 31.895647,
    late: 35.894724,
    id: "7",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Amman",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place1.png",
      "assets/images/img_png/place1.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
];
