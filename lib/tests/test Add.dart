// import 'package:flutter/material.dart';
// import 'package:turathi/core/models/place_model.dart';
// import 'package:turathi/core/models/testModel.dart';
// import 'package:turathi/core/services/testService.dart';
// import 'package:turathi/testView.dart';
//
// import 'core/services/place_service.dart';
//
// class AddTest extends StatefulWidget {
//   const AddTest({super.key});
//
//   @override
//   State<AddTest> createState() => _AddTestState();
// }
//
// class _AddTestState extends State<AddTest> {
//   @override
//   Widget build(BuildContext context) {
//     PlaceService service = PlaceService();
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text("Add test"),
//               onPressed: (){
//                 service.addPlace(PlaceModel(id: 'testPlace1',distance: '10'));
//                 service.addPlace(PlaceModel(id: 'testPlace2',distance: '20'));
//                 service.addPlace(PlaceModel(id: 'testPlace3',distance: '30'));
//
//
//               }
//               ,
//             ),
//             ElevatedButton(
//               child: Text("move "),
//               onPressed: (){
//                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>TestView() ));
//
//               }
//               ,
//             ),
//             ElevatedButton(
//               child: Text("Edit test num 2"),
//               onPressed: (){
//                 service.updatePlace(PlaceModel(id: 'testPlace1',distance: '100'));
//
//               }
//               ,
//             ),
//           ],
//         ),
//       )
//     );
//   }
//
// }
//
//
//
