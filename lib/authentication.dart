import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';

class Authen {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithEmail(String email, String pass) async {
    FirebaseUser user =
        (await _auth.signInWithEmailAndPassword(email: email, password: pass))
            .user;
    return user;
  }

  static Future<dynamic> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }
}
