import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/posts.dart';
import 'package:fitfunction/screens/homePages/postPages/comment_post.dart';
import 'package:fitfunction/screens/homePages/postPages/create_post.dart';
import 'package:fitfunction/screens/homePages/postPages/edit_post.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

//String urlProfile =
//    'https://firebasestorage.googleapis.com/v0/b/fitfunction-1d97a.appspot.com/o/cover.png?alt=media&token=8d9ec91b-eb87-41bf-b95d-ab842a33b4d6';

DateTime now = DateTime.now();
String timStamp = DateFormat('kk:mm:ss').format(now);
Post post = Post();

Future getUserInfo() async {
  Firestore fireStoreInstance = Firestore.instance;
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  return fireStoreInstance.collection("Users").document(firebaseUser.uid).get();
}

class _PostPageState extends State<PostPage> {
  Widget circleAvatars(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data['urlProfile']),
              backgroundColor: Colors.transparent,
            ),
            title: SizedBox(
              height: 30,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "ສ້າງໂພສໃໝ່",
                  textAlign: TextAlign.left,
                ),
                onPressed: () {
                  //print(currentUser.uid.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BuildPost(snapshot.data['urlProfile']),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

//  Future<int> getPost() async {
//    Firestore store = Firestore.instance;
//    QuerySnapshot querySnapshot =
//        await store.collection('Posts').getDocuments();
//    return querySnapshot.documents.length;
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('Posts').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgress(
                title: 'ກຳລັງໂຫລດ...',
              ),
            );
          } else if (snapshot == null) {
            return Container();
          } else {
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 13, top: 8),
                  height: 55,
                  child: circleAvatars(context),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot snapPost =
                          snapshot.data.documents[index];
                      var ngo2 = TimerCurrent()
                          .readTimestamp(snapPost.data['timestamp']);
                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('Users')
                            .document(snapPost.data['userID'])
                            .snapshots(),
                        builder: (context, snapName) {
                          if (!snapName.hasData) {
                            return Container();
                          }
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    // color: Colors.red,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            snapName.data['urlProfile']),
                                      ),
                                      title: Text(snapName.data['name'] +
                                          ' ' +
                                          snapName.data['surname']),
                                      subtitle: Text(ngo2),
                                      trailing: currentUser.uid ==
                                              snapPost.data['userID']
                                          ? PopupMenuButton(
                                              onSelected: (value) {
                                                chooseItem(
                                                    value,
                                                    snapPost.documentID,
                                                    snapPost);
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: Text('ບັນທຶກ'),
                                                  value: 1,
                                                ),
                                                PopupMenuItem(
                                                  child: Text('ແກ້ໄຂ'),
                                                  value: 2,
                                                ),
                                                PopupMenuItem(
                                                  child: Text('ລຶບ'),
                                                  value: 3,
                                                ),
                                              ],
                                            )
                                          : PopupMenuButton(
                                              onSelected: (value) {
                                                chooseItem(
                                                    value,
                                                    snapPost.documentID,
                                                    snapPost);
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: Text('ບັນທຶກ'),
                                                  value: 1,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      bottom: 5,
                                      right: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          snapPost.data['caption'] == null
                                              ? ''
                                              : snapPost.data['caption']),
                                    ),
                                  ),
                                  Image(image: CachedNetworkImageProvider(snapPost.data['urlPhoto'],)),
                                  Container(
                                    height: 50,
                                    //color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        FlatButton.icon(
                                          icon: Icon(
                                            Icons.comment,
                                            color: Colors.orange,
                                          ),
                                          label: StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('Comments')
                                                .where('postID',
                                                    isEqualTo:
                                                        snapPost.documentID)
                                                .snapshots(),
                                            builder:
                                                (context, snapCommentLength) {
                                              if (!snapCommentLength.hasData) {
                                                return Text('0 ຄວາມຄິດເຫັນ');
                                              }
                                              return Text(
                                                  '${snapCommentLength.data.documents.length} ຄວາມຄິດເຫັນ');
                                            },
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentPage(snapPost
                                                          .documentID
                                                          .toString())),
                                            );
                                          },
                                        ),
                                        FlatButton.icon(
                                          icon: snapPost.data['uidLike']
                                                  .contains(currentUser.uid)
                                              ? Icon(Icons.favorite,
                                                  color: Colors.orange)
                                              : Icon(Icons.favorite_border,
                                                  color: Colors.black87),
                                          label: Text(snapPost
                                              .data['uidLike'].length
                                              .toString()),
                                          onPressed: () {
                                            if (snapPost.data['uidLike']
                                                .contains(currentUser.uid)) {
                                              Firestore.instance
                                                  .collection('Posts')
                                                  .document(snapPost.documentID)
                                                  .updateData({
                                                'uidLike':
                                                    FieldValue.arrayRemove(
                                                        [currentUser.uid])
                                              });
                                            } else {
                                              Firestore.instance
                                                  .collection('Posts')
                                                  .document(snapPost.documentID)
                                                  .updateData({
                                                'uidLike':
                                                    FieldValue.arrayUnion(
                                                        [currentUser.uid])
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void chooseItem(value, String currentPostID, DocumentSnapshot snapPost) {
    switch (value) {
      case 1:
        Stream<QuerySnapshot> savePostSnap = Firestore.instance
            .collection('SavePost')
            .where('postID', isEqualTo: currentPostID)
            .where('userID', isEqualTo: currentUser.uid)
            .snapshots();
        savePostSnap.listen((event) {
          print(event.documents.length.toString());
          if (event.documents.length > 0) {
            print('Mg save Leo');
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'ທ່ານໄດ້ບັນທຶກແລ້ວ',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
            ));
          } else {
            post.savePost(currentPostID);
            successDialog(context, 'ບັນທຶກສຳເລັດແລ້ວ');
          }
        });

        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => EditPost(
              currentPostID,
              snapPost.data['caption'].toString(),
              snapPost.data['urlPhoto'].toString(),
            ),
          ),
        );
        break;
      case 3:
        print(currentPostID);
        post.deletePost(currentPostID);
        break;
    }
  }
}
