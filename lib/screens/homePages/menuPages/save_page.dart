import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
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
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
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
                    return Column(
                      children: [
                        Container(
                          child: Text(snapPost.data['caption']),
                        ),
                        Image.network(snapPost.data['urlPhoto']),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
