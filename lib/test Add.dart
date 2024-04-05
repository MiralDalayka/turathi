import 'package:flutter/material.dart';
import 'package:turathi/core/models/testModel.dart';
import 'package:turathi/core/services/test_service.dart';
import 'package:turathi/testView.dart';

class AddTest extends StatefulWidget {
  const AddTest({super.key});

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  @override
  Widget build(BuildContext context) {
    TestService service = TestService();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Add test"),
              onPressed: (){
                service.addTest(TestModel(title: 'title4', num: 4));
                service.addTest(TestModel(title: 'title5', num: 5));
                service.addTest(TestModel(title: 'title6', num: 6));
        
              }
              ,
            ),
            ElevatedButton(
              child: Text("move "),
              onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>TestView() ));
        
              }
              ,
            ),
            ElevatedButton(
              child: Text("Edit test num 2"),
              onPressed: (){
                service.updateTest(TestModel(title: 'updated test', num: 2));

              }
              ,
            ),
          ],
        ),
      )
    );
  }
}
