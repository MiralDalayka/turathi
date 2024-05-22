import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import '../data_layer.dart';
class RequestProvider extends ChangeNotifier {
  final RequestService _requestService = RequestService();

  Future<String> addRequest(RequestModel model, File file) async {
    String msg =
        (await _requestService.addRequest(model, file).whenComplete(() {
      log("Request added successfully");
    }));
    return msg;
  }

  Future<String> getRequestByUserId() async {
    RequestModel temp = await _requestService.getRequestByUserId();
    if (temp.requestId == "-1") {
      return "Not Found";
    }
    return temp.status!;
  }

}
