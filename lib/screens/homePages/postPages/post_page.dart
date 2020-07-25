import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/screens/homePages/postPages/create_post.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

DateTime now = DateTime.now();
String timStamp = DateFormat('kk:mm:ss').format(now);

String urlProfile =
    'https://firebasestorage.googleapis.com/v0/b/fitfunction-8d4d1.appspot.com/o/profiles%2Fprofile.png?alt=media&token=36c01c8f-4ca4-41d5-ac93-b771d9410263';

class _PostPageState extends State<PostPage> {
  Widget circleAvatars(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(urlProfile),
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
            "What is on your mind?",
            textAlign: TextAlign.start,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => BuildPost(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future getPost() async {
    Firestore store = Firestore.instance;
    QuerySnapshot querySnapshot =
        await store.collection('Posts').getDocuments();
    return querySnapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPost(),
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
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
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
                                    backgroundImage: NetworkImage(urlProfile),
                                  ),
                                  title: Text('David Morgan'),
                                  subtitle: Text(timStamp.toString()),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {},
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
                                      snapshot.data[index].data['caption']==null?'':snapshot.data[index].data['caption']),
                                ),
                              ),
                              Image.network(
                                  snapshot.data[index].data['urlPhoto']),
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
                                      label: Text('5 ຄວາມຄິດເຫັນ'),
                                      onPressed: () {},
                                    ),
                                    FlatButton.icon(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.orange,
                                      ),
                                      label: Text('15'),
                                      onPressed: () {
                                        //checkCurentUser();
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

//  Future<void> checkCurentUser()async {
//    FirebaseAuth _auth=FirebaseAuth.instance;
//    FirebaseUser user=await _auth.currentUser();
//    print(user.uid);
//  }
}
