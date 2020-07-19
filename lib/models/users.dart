import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore userModel = Firestore.instance;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _birthDay;
  String _gender;
  String _urlPhoto;

  Users();

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get surname => _surname;

  set surname(String value) {
    _surname = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get birthDay => _birthDay;

  set birthDay(String value) {
    _birthDay = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get urlPhoto => _urlPhoto;

  set urlPhoto(String value) {
    _urlPhoto = value;
  }

//  Users.fromMap(Map<String, dynamic> map) {
//    name = map['name'];
//    surname = map['surname'];
//    gender = map['gender'];
//    birthDay = map['birthDay'];
//    email = map['email'];
//    password = map['password'];
//    urlPhoto = map['urlPhoto'];
//  }

  Future<FirebaseUser> createUserWithEmail() async {
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
