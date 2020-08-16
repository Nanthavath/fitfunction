import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPost extends StatefulWidget {
  String postID;
  String caption;
  String urlPhoto;

  EditPost(this.postID, this.caption, this.urlPhoto);

  @override
  _EditPostState createState() =>
      _EditPostState(caption: caption, postID: postID, urlPhoto: urlPhoto);
}

class _EditPostState extends State<EditPost> {
  String postID;
  String caption;
  String urlPhoto;
  TextEditingController textEditingController = TextEditingController();

  _EditPostState({
    this.postID,
    this.caption,
    this.urlPhoto,
  });

  File file;
  String newCaption;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = caption;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('ແກ້ໄຂ'),
        actions: [
          FlatButton(
            child: Icon(Icons.done),
            onPressed: () {
              setState(() {
                loading = true;
                updatePost().then((value) {
                  loading = false;
                  Navigator.of(context).pop();
                });
              });
            },
          )
        ],
      ),
      body: loading == true
          ? CircularProgress(
              title: 'ກຳລັງບັນທຶກ...',
            )
          : Container(
              margin: EdgeInsets.only(right: 15, left: 10),
              child: ListView(
                children: [
                  TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => newCaption = value,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    child: InkWell(
                      child: file == null
                          ? Image.network(urlPhoto)
                          : Image.file(file),
                      onTap: () {
                        actionSheetCover();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void actionSheetCover() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('ປ່ຽນຮູບພາບ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  showChoicePicture();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('ຍົກເລີກ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  Future<void> showChoicePicture() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ເລືອກທີ່ມາຂອງຮູບພາບ'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('ເລືອຮູບພາບຈາກເຄື່ອງ'),
                    ),
                    onTap: () {
                      choosePictureCover(ImageSource.gallery);

                      Navigator.of(context).pop();
                    },
                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
                  Divider(),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('ຖ່າຍຮູບ'),
                    ),
                    onTap: () {
                      choosePictureCover(ImageSource.camera);
                      //setCoverProfile();
                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> choosePictureCover(ImageSource imageSource) async {
    final picker = ImagePicker();
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        file = File(object.path);
      });
    } catch (ex) {}
  }

  Future<void> updatePost() async {
    if (file == null) {
      await Firestore.instance.collection('Posts').document(postID).updateData({
        'caption': newCaption,
      }).then((value) => print('Update Caption Success'));
    } else {
      print(newCaption);
      Random random = Random();
      int i = random.nextInt(999999999);
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child('updateposts/posts-fitfunction$i');
      StorageUploadTask uploadTask = reference.putFile(file);
      String urlPost = await (await uploadTask.onComplete).ref.getDownloadURL();
      await Firestore.instance.collection('Posts').document(postID).updateData({
        'caption': newCaption,
        'urlPhoto': urlPost,
      }).then((value) => print('Update Success'));
    }
  }
}
