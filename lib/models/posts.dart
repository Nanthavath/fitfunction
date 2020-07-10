import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post {
  String userid;
  String captions;
  String urlPost;
  String timestap;
  Post(this.userid, this.captions, this.urlPost, this.timestap);


}
