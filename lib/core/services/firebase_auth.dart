import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
 static final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signupwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("credential signUp is done ");

      return credential.user;
    } catch (e) {
      print("some error occured in FirebaseAuthService $e");
    }
    return null;
  }

  Future<User?> signinwithemailandpassword(
      String email, String password) async {
    try {
      
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      // SharedPreferences prefsSignIN = await SharedPreferences.getInstance();

      // prefsSignIN.setString('uid', credential.user!.uid);
      

      return credential.user;
      
    } catch (e) {
      print("some error occured $e");
    }
    return null;
  }

logOut()async{
await  auth.signOut();
}
  


}
