import 'dart:ui';

import 'package:flutter/material.dart';

class PlaceModel {
  final String ussid; // user id
  final String id;
  final String title, description, status, location, type, distance;
  final List<String> commentsPlace;
  final List<dynamic> images;
  final int comments_counter;
  final int like, disLike;
  bool isFavourite, isPopular;
  double long, late;

  PlaceModel({
    this.ussid = "",
    required this.images,
    required this.commentsPlace,
    required this.title,
    required this.distance,
    this.comments_counter = 0,
    required this.id,
    required this.description,
    required this.status,
    required this.type,
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
    comments_counter: 100,
    type: "New Place",
    long: 35.890933,
    late: 31.900762,
    distance: "10",
    id: "1",
    commentsPlace: ["something", "somethig"],
    status: "Closed for maintenance",
    location: "Amman , Downtown ",
    like: 33,
    disLike: 124,
    images: [
      "assets/images/img_png/Dukes.png",
      "assets/images/img_png/place3.png",
      "assets/images/img_png/Dukes.png",
    ],
    title: "Duke's Diwan",
    description:
        "The Duke's Diwan is an arts and cultural center and historic house museum. Located on King Faisal Street in downtown Amman, it is housed in one of the city's oldest buildings. Built in 1924 as Amman's first post office, the building later became the Finance Ministry, and then the Haifa Hotel from 1948 to 1998 it was rented by Mamdouh Bisharat, a Jordanian heritage conservationist and businessman, at double its price to prevent the building's owners from knocking it down. Bisharat",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    comments_counter: 100,
    long: 35.86536868153866,
    late: 32.53594091877603,
    type: "New Place",
    distance: "10",
    id: "2",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Irbidd",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place3.png",
      "assets/images/img_png/place3.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    comments_counter: 100,
    long: 31.895647,
    late: 35.894724,
    distance: "10",
    type: "New Place",
    id: "3",
    commentsPlace: ["something", "somethig"],
    status: "Close",
    location: "Irbid",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/place3.png",
      "assets/images/img_png/place3.png",
    ],
    title: "Duke's Diwan",
    description: "description",
    isFavourite: false,
    isPopular: false,
  ),
  PlaceModel(
    comments_counter: 100,
    long: 31.895647,
    late: 35.894724, //37.785834
    id: "4",
    distance: "10",
    type: "New Place",
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
