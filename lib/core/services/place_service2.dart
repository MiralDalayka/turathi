import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/place_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> productsCollection =
    _firestore.collection('your_collection_name'); 

Future<List<PlaceModel>> getPlaces() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await productsCollection.get();

    return snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      Map<String, dynamic> data = doc.data()!;

      return PlaceModel(
        id: data['id'] ?? 0,
        images: List<String>.from(data['images'] ?? []),
     
        title: data['title'] ?? '',
        description: data['description'] ?? '', commentsPlace: [], distance: '', status: '', state: '', location: '',
      
      );
    }).toList();
  } catch (e) {
    print('Error fetching products: $e');
    return []; 
  }
}
