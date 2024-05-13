
import 'package:crypt/crypt.dart';

String hashPassword(String password) {
return Crypt.sha512(password).toString();
}

bool passIsValid(String cryptFormatHash, String enteredPassword) =>
  Crypt(cryptFormatHash).match(enteredPassword);



