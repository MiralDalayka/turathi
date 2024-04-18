import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Test{
  Future<String> _load() async {
    var url =
    Uri.parse("https://www.google.com/maps/dir/?api=1&origin=31.900762,35.890933&destination=32.49517491030077,35.991236423865466");

    var response = await http.get(url);
    // response.statusCode --> 200

    if (response.statusCode == 200) {
      return response.body;
    }
    return "ERROR";
  }
}


