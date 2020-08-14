import 'dart:math';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
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

// ignore: must_be_immutable
class BuildPost extends StatefulWidget {
  String urlProfile;

  BuildPost(this.urlProfile);

  @override
  _BuildPostState createState() => _BuildPostState(urlProfile);
}

class _BuildPostState extends State<BuildPost> {
  String urlProfile;

  _BuildPostState(this.urlProfile);

  Post post = Post();
  File file;
  final picker = ImagePicker();
  bool loading = false;

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
                  hintText: 'ຄຳອະທິບາຍ',
                ),
                onChanged: (value) => post.captions = value,
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
                  loading == false
                      ? Card(
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
                                            'images/picture_480px.png',
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
                          ))
                      : Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/2,
                            child: Center(
                                child: CircularProgress(
                              title: 'ກຳລັງໂພສ...',
                            )),
                          ),
                        ),
                ],
              )),
              SubmitButton(
                title: 'ສ້າງໂພສ',
                onPressed: () {
                  setState(() {
                    loading = true;
                    post.uploadImageToStorage(file).then((value) {
                      loading = false;
                      Navigator.of(context).maybePop();
                      print(currentUser.uid);
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
