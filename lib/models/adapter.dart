import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

Users myUser;
FirebaseUser currentUser;

class Controller {
  static Future<void> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser().then((value){
     return currentUser=value;
    });


  }
}
