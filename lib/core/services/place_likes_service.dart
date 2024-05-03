// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:turathi/core/models/place_likes_model.dart';
// import 'package:turathi/core/models/place_model.dart';
// import 'package:turathi/core/providers/place_provider.dart';
// import 'package:turathi/core/services/place_service.dart';
//
// import '../../utils/shared.dart';
//
// class PlaceLikesService {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   String collection = "place_likes";
//
//   Future<bool> likePlace(PlaceModel model) async {
//     QuerySnapshot placesData = await _fireStore
//         .collection(collection)
//         .where('placeId', isEqualTo: model.id)
//         .where('userId', isEqualTo: userShared.id)
//         .get();
//     Map<String, dynamic> data = {};
//     if (placesData.docs.isEmpty) {
//       await _fireStore.collection(collection).add(PlaceLikes(
//               placeId: model.id,
//               disliked: false,
//               liked: true,
//               userId: userShared.id)
//           .toJson());
//     } else {
//       PlaceLikes tempPlaceLikesModel;
//       data["liked"] = placesData.docs[0].get("liked");
//       data["disliked"] = placesData.docs[0].get("disliked");
//       data["placeId"] = model.id;
//       data["userId"] = userShared.id;
//
//       tempPlaceLikesModel = PlaceLikes.fromJson(data);
//       if(tempPlaceLikesModel.disliked==true) {
//         tempPlaceLikesModel.disliked=false;
//       }
//       if(tempPlaceLikesModel.liked==true) {
//         tempPlaceLikesModel.liked=false;
//         return false; //decrease likes
//       }
//         tempPlaceLikesModel.liked = true;
//     }
//     return true;//increase likes
//
//   }
// }
