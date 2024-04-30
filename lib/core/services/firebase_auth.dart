import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signupwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
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
      
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // SharedPreferences prefsSignIN = await SharedPreferences.getInstance();

      // prefsSignIN.setString('uid', credential.user!.uid);
      

      return credential.user;
      
    } catch (e) {
      print("some error occured $e");
    }
    return null;
  }


  

  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
