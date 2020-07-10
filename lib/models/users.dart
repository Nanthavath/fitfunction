import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore userModel = Firestore.instance;
  static String name;
  static String surname;
  static String email;
  static String password;
  static String birthDay;
  static String gender;
  static String urlPhoto;

//  Users(
//      {this.name,
//      this.surname,
//      this.email,
//      this.password,
//      this.birthDay,
//      this.gender,
//      this.urlPhoto});

//  Users.fromMap(Map<String, dynamic> map, this.uid) {
//    name = map['name'];
//    surname = map['surname'];
//    gender = map['gender'];
//    birthDay=map['birthDay'];
//    email=map['email'];
//    password=map['password'];
//    urlPhoto=map['urlPhoto'];
//  }

  static Future<FirebaseUser> createUserWithEmail() async {
    try {
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      final String uid = user.uid;
      Map<String, dynamic> maps = Map();
      maps['name'] = name;
      maps['surname'] = surname;
      maps['gender'] = gender;
      maps['birthDay'] = birthDay;
      maps['email'] = email;
      maps['password'] = password;
      maps['urlPhoto'] = urlPhoto;
      await userModel.collection('Users').document(uid).setData(maps);
      return user;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
