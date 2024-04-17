import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

enum PlaceStatus {
  Closed_For_Maintenance,
  Open,
} //

enum PlaceState { NewPlace, TrustWorthy } //

class PlaceModel {
  String? userID;
  String? id;
  String? title;
  String? description;
  String? status = PlaceStatus.Open.toString();
  String? location;
  String? state = PlaceState.NewPlace.toString();
  String? distance;
  List<String>? commentsPlace = [];
  List<String>? images;
  int? like = 0;
  int? disLike = 0;
  bool? isVisible = true;
  bool? isFavourite = false; //BACK
  double? long;
  double? late;

  PlaceModel(
      {this.userID,
      required this.id,
      this.title,
      this.description,
      this.status,
      this.location,
      this.state,
      this.distance,
      this.commentsPlace,
      this.images,
      this.like,
      this.disLike,
      this.isVisible,
      this.isFavourite,
      this.long,
      this.late});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    location = json['location'];
    state = json['state'];
    distance = json['distance'];
    commentsPlace = json['commentsPlace'].cast<String>();
    images = json['images'].cast<String>();
    like = json['like'];
    disLike = json['disLike'];
    isVisible = json['isVisible'];
    isFavourite = json['isFavourite'];
    long = json['long'];
    late = json['late'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['location'] = this.location;
    data['state'] = this.state;
    data['distance'] = this.distance;
    data['commentsPlace'] = this.commentsPlace;
    data['images'] = this.images;
    data['like'] = this.like;
    data['disLike'] = this.disLike;
    data['isVisible'] = this.isVisible;
    data['isFavourite'] = this.isFavourite;
    data['long'] = this.long;
    data['late'] = this.late;
    return data;
  }
}

List<PlaceModel> demoPlaces = [
  PlaceModel(
    isFavourite: true,
    isVisible: true,
    userID: 'q',
    state: "New Place",
    long: 35.890933,
    late: 31.900762,
    distance: "10",
    id: "1",
    commentsPlace: ["something", "somethig"],
    status: PlaceStatus.Closed_For_Maintenance.toString(),
    location: "Amman , Downtown ",
    like: 0,
    disLike: 0,
    images: [
      "assets/images/img_png/Dukes.png",
      "assets/images/img_png/place3.png",
      "assets/images/img_png/Dukes.png",
    ],
    title: "Duke's Diwan",
    description:
        "The Duke's Diwan is an arts and cultural center and historic house museum. Located on King Faisal Street in downtown Amman, it is housed in one of the city's oldest buildings. Built in 1924 as Amman's first post office, the building later became the Finance Ministry, and then the Haifa Hotel from 1948 to 1998 it was rented by Mamdouh Bisharat, a Jordanian heritage conservationist and businessman, at double its price to prevent the building's owners from knocking it down. Bisharat",
  ),
  PlaceModel(
    isFavourite: true,
    isVisible: true,
    userID: 'q',
    long: 35.86536868153866,
    late: 32.53594091877603,
    state: "New Place",
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
  ),
  PlaceModel(
    isFavourite: true,
    isVisible: true,
    userID: 'q',
    long: 31.895647,
    late: 35.894724,
    distance: "10",
    state: "New Place",
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
  ),
  PlaceModel(
    isFavourite: true,
    isVisible: true,
    userID: 'q',
    long: 31.895647,
    late: 35.894724,
    //37.785834
    id: "4",
    distance: "10",
    state: "New Place",
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
  ),
];

class PlaceList {
  List<PlaceModel> places;

  PlaceList({required this.places});

  factory PlaceList.fromJson(List<dynamic> data) {
    log("I'm In Place List Factory");
    //1. temp list
    List<PlaceModel> tempPlaces = [];
    tempPlaces = data.map((item) {
      return PlaceModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return PlaceList(places: tempPlaces);
  }
}
