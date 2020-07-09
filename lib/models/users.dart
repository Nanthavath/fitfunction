import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final String uid;
  String name;
  String surname;
  String email;
  String password;
  String birthDay;
  String gender;

  Users(
      {this.uid,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.birthDay,
      this.gender});

  Future<String> createUserWithEmail() async {
    FirebaseUser user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.email;
  }
}
