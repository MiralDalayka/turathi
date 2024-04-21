import 'package:turathi/core/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../core/functions/get_current_location.dart';

double selectedNearestLat = 0;
double selectedNearestLog = 0;
double userNearestLat = 0;
double  userNearestLog = 0;


double addPlaceLocatonLat=0;

double addPlaceLocatonLong=0;


double addEventLocatonLat=0;

double addEventLocatonLog=0;
enum ImageType {
  placeImages,
  questionImages,
  eventImages,


}
Uuid uuid = const Uuid();

UserModel user = UserModel.empty() ;

