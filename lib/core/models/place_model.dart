import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:turathi/core/models/comment_model.dart';

import '../../utils/shared.dart';
import '../functions/calculate_distanceInKm.dart';

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
  String? status;

  String? address;
  String? state;

  List<CommentModel>? commentsPlace;
  List<String>? images;
  int? like;

  int? disLike;

  bool? isVisible;

  double? longitude;
  double? latitude;

  PlaceModel(
      {required this.title,
      required this.description,
      required this.address,
      required this.longitude,
      required this.latitude}) {
    id = uuid.v4();
    userID = user.id;
    status = PlaceStatus.Open.name;
    state = PlaceState.NewPlace.name;
    commentsPlace = [];
    like = 0;
    disLike = 0;
    isVisible = true;
  }

  PlaceModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    address = json['address'];
    state = json['state'];
    like = json['like'];
    disLike = json['disLike'];
    isVisible = json['isVisible'];
    longitude = json['long'];
    latitude = json['late'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['address'] = this.address;
    data['state'] = this.state;
    data['like'] = this.like;
    data['disLike'] = this.disLike;
    data['isVisible'] = this.isVisible;
    data['long'] = this.longitude;
    data['late'] = this.latitude;
    return data;
  }
}

List<PlaceModel> demoPlaces = [
  PlaceModel(
    longitude: 35.890933,
    latitude: 31.900762,
    address: "Amman , Downtown ",
    title: "Duke's Diwan",
    description:
        "The Duke's Diwan is an arts and cultural center and historic house museum. Located on King Faisal Street in downtown Amman, it is housed in one of the city's oldest buildings. Built in 1924 as Amman's first post office, the building later became the Finance Ministry, and then the Haifa Hotel from 1948 to 1998 it was rented by Mamdouh Bisharat, a Jordanian heritage conservationist and businessman, at double its price to prevent the building's owners from knocking it down. Bisharat",
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
