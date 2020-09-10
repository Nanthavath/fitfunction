import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/comment_model.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  String postID;

  CommentPage(this.postID);

  @override
  _CommentPageState createState() => _CommentPageState(postID);
}

CommentModel _commentModel = CommentModel();
bool tabEdit = false;

class _CommentPageState extends State<CommentPage> {
  String tapEditcmID;
  String postID;
  TextEditingController captionController = TextEditingController();

  _CommentPageState(this.postID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຄວາມຄິດເຫັນທັລໝົດ'),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
//          Align(
//              alignment: Alignment.topLeft,
//              child: BackButton(
//                color: Colors.orange,
//
//              )),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Comments')
                  .where('postID', isEqualTo: postID)
                  .snapshots(),
              builder: (context, commentSnap) {
                if (!commentSnap.hasData) {
                  return Container();
                }
                if (commentSnap.data.documents.length == 0) {
                  return Container(
                    child: Center(
                      child: Text('ບໍ່ມີຄວາມຄິດເຫັນ'),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: commentSnap.data.documents.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot snapComment =
                          commentSnap.data.documents[index];
                      return FutureBuilder(
                        future: Firestore.instance
                            .collection('Users')
                            .document(snapComment.data['userID'])
                            .get(),
                        builder: (context, snapUsercm) {
                          if (!snapUsercm.hasData) {
                            return Container();
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapUsercm.data['urlProfile']),
                            ),
                            title: Text(
                              snapUsercm.data['name'] +
                                  ' ' +
                                  snapUsercm.data['surname'],
                              style: TextStyle(color: Colors.orange),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('${snapComment.data['caption']}',
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                  TimerCurrent().readTimestamp(
                                      snapComment.data['timestamp']),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            trailing: currentUser.uid ==
                                    snapComment.data['userID']
                                ? PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 1) {
                                        tapEditcmID = snapComment.documentID;
                                        captionController.text =
                                            snapComment.data['caption'];
                                        tabEdit=true;
                                        setState(() {

                                        });
                                      } else {
                                        deleteComment(
                                            snapComment.documentID.toString());
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text('ແກ້ໄຂ'),
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Text('ລຶບ'),
                                        value: 2,
                                      ),
                                    ],
                                  )
                                : Icon(Icons.more_vert),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 20,
            width: MediaQuery.of(context).size.width / 1,
            child: Row(
              children: [
                Icon(
                  Icons.comment,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Center(
                    child: TextFormField(
                      controller: captionController,
                      decoration: InputDecoration(hintText: 'ສະແດງຄວາມຄິດເຫັນ'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                tabEdit == false
                    ? InkWell(
                        child: Icon(Icons.send),
                        onTap: () {
                          _commentModel.caption = captionController.text;
                          _commentModel.addComment(postID);
                          captionController.text = '';
                        },
                      )
                    : InkWell(
                        child: Icon(Icons.reply),
                        onTap: () {
//                          _commentModel.disPlay();
//                          //print(_commentModel.caption);
                          Firestore.instance.collection('Comments').document(tapEditcmID).updateData({
                            'caption':captionController.text,
                          });
                          setState(() {
                            tabEdit=false;
                          });
                          captionController.text = '';
                        },
                      ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future<void> deleteComment(commentID) async {
    await Firestore.instance
        .collection('Comments')
        .document(commentID)
        .delete();
  }
}
