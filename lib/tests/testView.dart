
import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/place_service.dart';

import '../core/functions/files_stoage.dart';
import '../core/services/file_storage_service.dart';




class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  List<String>? placeList;

  @override
  Widget build(BuildContext context) {
    FilesStorageService service = FilesStorageService();
    return Scaffold(
      appBar: AppBar(
      ),
        body: FutureBuilder(
      future: service.getPlaceImages('file44'),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        placeList = data as List<String>;
        if (placeList!.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'OOPS\n',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'No Items in current time\n',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Add Item',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          ])
                    ])),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: placeList!.length,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(placeList![index]),
                )),
          ),
        );
      },
    ));
  }
}