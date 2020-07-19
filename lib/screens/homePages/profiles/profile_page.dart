import 'dart:io';

import 'package:fitfunction/screens/homePages/profiles/edit_profile.dart';
import 'package:fitfunction/screens/homePages/profiles/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File fileCover;
  File fileProfile;
  final picker = ImagePicker();

  Future<void> choosePictureCover(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        fileCover = File(object.path);
      });
    } catch (ex) {}
  }

  Future<void> choosePictureProfile(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        fileProfile = File(object.path);
      });
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              //color: Colors.green,
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      //color: Colors.blue,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: fileCover == null
                                  ? AssetImage('images/cats.jpg')
                                  : FileImage(fileCover),
                              fit: BoxFit.fill)),
                    ),
                    onTap: () {
                      actionSheetCover();
                    },
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                              image: DecorationImage(
                                image: fileProfile == null
                                    ? AssetImage('images/app_logo.png')
                                    : FileImage(fileProfile, scale: 1.0),
                              )),
                        ),
                        onTap: () {
                          //actionSheetModel();
                          actionSheetProfile();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Nanthavath Vongsouna',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton(
                child: Text(
                  'ແກ້ໄຂ',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ສະຖານະ: Single'),
                    Divider(),
                    Text('ຄຳອະທິບາຍ:Workout Work body'),
                    Divider(),
                    Text('Level:Basic'),
                    Divider(),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
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
                child: Text('ເບິ່ງຮູບຫນ້າປົກ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProfile(
                            file: fileCover,
                          )));
                },
              ),
              CupertinoActionSheetAction(
                child: Text('ປ່ຽນຮູບຫນ້າປົກ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  changeCover();
                },
              ),
            ],
          );
        });
  }

  void changeCover() {
    showChoiceDialogCover();
  }

  Future<void> showChoiceDialogCover() {
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
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> showChoiceDialogProfile() {
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
                      choosePictureProfile(ImageSource.gallery);
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
                      choosePictureProfile(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void actionSheetProfile() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('ເບິ່ງຮູບໂປຣຟາຍ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProfile(
                            file: fileCover,
                          )));
                },
              ),
              CupertinoActionSheetAction(
                child: Text('ປ່ຽນຮູບໂປຣຟາຍ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  changeProfile();
                },
              ),
            ],
          );
        });
  }

  void changeProfile() {
    showChoiceDialogProfile();
  }
}
