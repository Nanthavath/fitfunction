import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithEmail(String email, String pass) async {
    FirebaseUser user =
        (await _auth.signInWithEmailAndPassword(email: email, password: pass))
            .user;
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }
}
