import 'package:turathi/core/models/user_model.dart';
import 'package:uuid/uuid.dart';


bool checkUser=false;//this is to check the user if is null or not when he sign in
double selectedNearestLat = 0;
double selectedNearestLog = 0;
// double userNearestLat = 0;
// double  userNearestLog = 0;


double addPlaceLocatonLat=0;

double addPlaceLocatonLong=0;


double addEventLocatonLat=0;

double addEventLocatonLog=0;
enum ImageType {
  placesImages,
  questionImages,
  eventImages,


}
Uuid uuid = const Uuid();

UserModel sharedUser = UserModel.empty() ;

String oldemail="";

bool AdminCheck=false;




