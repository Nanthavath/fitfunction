import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> createAccountWithEmail() async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: users.email, password: users.password))
        .user;
    return user;
  }

  Future<FirebaseUser> signInWithEmail() async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: users.email, password: users.password))
        .user;
    return user;
  }

  signOut() async {
    await _auth.signOut();
  }
}
