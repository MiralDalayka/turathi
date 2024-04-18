 import 'package:crypt/crypt.dart';

String hashPassword(String password) {
return Crypt.sha512(password).toString();
}