import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການທີບັນທຶກ'),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('SavePost')
              .where('userID', isEqualTo: currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else if (snapshot.data == null) {
              return Container();
            } else {
              return ListView.builder(
                itemCount: (snapshot.data.documents.length) < 0
                    ? 1
                    : snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot snapSave = snapshot.data.documents[index];
                  return StreamBuilder(
                    stream: Firestore.instance
                        .collection('Posts')
                        .document(snapSave.data['postID'].toString())
                        .snapshots(),
                    builder: (context, snapPost) {
                      if (!snapPost.hasData) {
                        return Container();
                      }
                      return Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FutureBuilder(
                            future: Firestore.instance
                                .collection('Users')
                                .document(snapPost.data['userID'])
                                .get(),
                            builder: (context, snapUser) {
                              if (!snapUser.hasData) {
                                return Container();
                              }
                              return Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapUser.data['urlProfile']),
                                    ),
                                    title: Text(snapUser.data['surname']),
                                    trailing: PopupMenuButton(
                                      onSelected: (value) {
                                        value = 1;
                                        Firestore.instance
                                            .collection('SavePost')
                                            .document(snapSave.documentID)
                                            .delete()
                                            .then((value) {
                                          setState(() {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                'ລຶບສຳເລັດ',
                                                style: TextStyle(
                                                    color: Colors.red),
                                                textAlign: TextAlign.center,
                                              ),
                                            ));
                                          });
                                        });
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text('ຍົກເລີກບັນທຶກ'),
                                          value: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        (snapPost.data['caption'] == null)
                                            ? 'NoCaption'
                                            : snapPost.data['caption']),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: snapPost.data['urlPhoto'],
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
