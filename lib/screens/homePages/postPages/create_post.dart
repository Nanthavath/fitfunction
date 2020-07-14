import 'dart:math';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/buttonLabel.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitfunction/models/posts.dart';

class BuildPost extends StatefulWidget {
  @override
  _BuildPostState createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  Post post = Post();

  File file;
  final picker = ImagePicker();
  String urlProfile =
      'https://firebasestorage.googleapis.com/v0/b/fitfunction-8d4d1.appspot.com/o/profiles%2Fprofile.png?alt=media&token=36c01c8f-4ca4-41d5-ac93-b771d9410263';

  Widget takePhoto() {
    return ButtonLabel(
      title: 'ຖ່າຍຮູບ',
      icon: Icon(
        Icons.photo_camera,
        size: 40,
      ),
      onPressed: () {
        choosePicture(ImageSource.camera);
      },
    );
  }

  Future<void> choosePicture(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        file = File(object.path);
      });
    } catch (ex) {}
  }

  Widget pickPhoto() {
    return ButtonLabel(
      title: 'ເລືອກຮູບພາບ',
      icon: Icon(
        Icons.photo,
        size: 40,
      ),
      onPressed: () {
        choosePicture(ImageSource.gallery);
      },
    );
  }

  Widget circleAvatars() {
    return Container(
      height: 100,
      //color: Colors.orange,
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: <Widget>[
          Container(
            //color: Colors.green,
            height: 100, width: 50,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(urlProfile),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What is on your mind?',
                ),
                onChanged: (value) => Post.captions = value,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      leading: MyBackButton(),
                      title: Text(
                        'ສ້າງໂພສໃຫມ່',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Column(
                          children: <Widget>[
                            circleAvatars(),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: file == null
                                    ? Image.asset(
                                        'images/cats.jpg',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        file,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  takePhoto(),
                                  Container(
                                    color: Colors.grey,
                                    height: 20,
                                    width: 1,
                                  ),
                                  pickPhoto(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              )),
              SubmitButton(
                title: 'ສ້າງໂພສ',
                onPressed: () {
                  if (post.uploadImageToStorage(file) != null) {
                    Navigator.of(context).maybePop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
