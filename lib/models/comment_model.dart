import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';

class CommentModel {
  String _commentID;
  String _caption;

  String get commentID => _commentID;

  set commentID(String value) {
    _commentID = value;
  }

  Timestamp _timestamp;

  String get caption => _caption;

  set caption(String value) {
    _caption = value;
  }

  Timestamp get timestamp => _timestamp;

  set timestamp(Timestamp value) {
    _timestamp = value;
  }

  Future<void> addComment(String postID) async {
    timestamp = Timestamp.now();
    await Firestore.instance.collection('Comments').document().setData({
      'caption': caption,
      'timestamp': timestamp,
      'postID': postID,
      'userID': currentUser.uid,
    }).then((value) => print('Comment success'));
  }
  disPlay()=>print(caption);
}
