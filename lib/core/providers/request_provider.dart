import 'dart:developer';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:turathi/core/models/request_model.dart';
import 'package:turathi/core/services/request_service.dart';


class RequestProvider extends ChangeNotifier {
  final RequestService _requestService = RequestService();

  Future<String> addRequest(RequestModel model,File file) async {
    String msg = (await _requestService.addRequest(model,file).whenComplete(() {
      log("Request added successfuly");
    }));
    return msg;
  }
}
