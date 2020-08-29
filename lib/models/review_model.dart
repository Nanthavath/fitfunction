import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';

class ReviewModel {
  String _gymID;
  String viewID;

  String get gymID => _gymID;

  set gymID(String value) {
    _gymID = value;
  }

  String  _comment;
  String _userID;
  double _score;
  Timestamp _timestamp;

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  double get score => _score;

  set score(double value) {
    _score = value;
  }

  Timestamp get timestamp => _timestamp;

  set timestamp(Timestamp value) {
    _timestamp = value;
  }

  Future<void> addComment()async{
    timestamp=Timestamp.now();
   final docRef= await Firestore.instance.collection('ReviewGym').add(
      {
        'gymID':gymID,
        'score':score,
        'comment':comment,
        'timestamp':timestamp,
        'userID':currentUser.uid,
      }
    );
    viewID=docRef.documentID;
    print(viewID.toString());

  }
}