// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:turathi/core/functions/get_user_city.dart';
//
// void main(){
//   TestWidgetsFlutterBinding.ensureInitialized();
//   test("User city name function",() async {
//     String address = await  UserCity(latitude: 32.569333, longitude: 35.836211);
//     expect(address, "Jordan Irbid");
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:turathi/core/functions/get_user_city.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.

void main() {
  group('Get User Place ', () {
    test('returns user location (City)', () async {
      String address = await UserCity(
          latitude: 32.35610920083562,
          longitude: 35.93027742036834); //32.35610920083562, 35.93027742036834
      expect(address, "Qafqafa"); //Tadmor
      //
      // String address2 = await UserCity(
      //     latitude: 32.31724733333662,
      //     longitude: 35.73396197322666); //32.31724733333662, 35.73396197322666
      // expect(address2, "Wadi as Salus");

      // String  address2 = await UserCity(
      //     latitude: 32.33406902547508,
      //     longitude: 35.750955583065895); //32.33406902547508, 35.750955583065895
      // expect(address2, "Ajloun");
    });
  });
}
