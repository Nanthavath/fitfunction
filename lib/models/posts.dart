import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:fitfunction/widgets/circularProgress.dart';

import 'adapter.dart';

class Post {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  Firestore userModel ;
  String _captions;
  String _urlPost;
  Timestamp timestamp;
  List<String> _uidLike;

  List<String> get uidLike => _uidLike;

  set uidLike(List<String> value) {
    _uidLike = value;
  }

  String get captions => _captions;

  set captions(String value) {
    _captions = value;
  }
  String get urlPost => _urlPost;

  set urlPost(String value) {
    _urlPost = value;
  }

  Future<String>uploadImageToStorage(File file) async {
    Random random = Random();
    int i = random.nextInt(999999999);
    StorageReference reference = storage.ref().child('posts/posts-fitfunction$i');
    StorageUploadTask uploadTask = reference.putFile(file);
    urlPost = await (await uploadTask.onComplete).ref.getDownloadURL();
    uploadToDatabase();
    return urlPost;
  }

  Future<void> uploadToDatabase() async {
    currentUser=await FirebaseAuth.instance.currentUser();
    userModel = Firestore.instance;
    timestamp=Timestamp.now();
    Map<String, dynamic> map = Map();
    map['caption'] = captions;
    map['urlPhoto'] = urlPost;
    map['userID'] = currentUser.uid;
    map['timestamp']=timestamp;
    map['uidLike']=uidLike=[];
    await userModel
        .collection('Posts')
        .document()
        .setData(map)
        .then((value) => print('upload success'));
  }
 Future<void> deletePost(String currentPost) async{
   await Firestore.instance.collection('Posts').document(currentPost).delete();
  }
  Future<void>savePost(String currentPostID)async{
    timestamp=Timestamp.now();
    Firestore.instance.collection('SavePost').document().setData({
      'postID':currentPostID,
      'timestamp':timestamp,
      'userID':currentUser.uid,
    });
  }
}
