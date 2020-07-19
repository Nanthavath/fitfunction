import 'dart:collection';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/users.dart';
import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future<void> createUserWithEmail(String email, String pass) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: pass))
        .user;
    notifyListeners();
  }
}
