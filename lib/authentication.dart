import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  creteAccount(String _email, String _pass) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: _email, password: _pass))
        .user;
  }
}
