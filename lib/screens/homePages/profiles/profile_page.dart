import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/homePages/profiles/edit_profile.dart';
import 'package:fitfunction/screens/homePages/profiles/view_profile.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
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
  Users users = Users();

  Future<void> choosePictureCover(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        fileCover = File(object.path);
        setCoverProfile();
      });
    } catch (ex) {}
  }

  Future<void> choosePictureProfile(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        fileProfile = File(object.path);
        setProfile();
      });
    } catch (ex) {}
  }

  // Controller _controller=Controller();
  Future getData() async {
    Firestore fireStoreInstance = Firestore.instance;
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return fireStoreInstance
        .collection("Users")
        .document(firebaseUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getData(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgress(
              title: 'ກຳລັງໂຫລດ',
            ),
          );
        } else {
          return Container(
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
                                image: snapshot.data['urlCover'] == null
                                    ? AssetImage('images/cats.jpg')
                                    : NetworkImage('https://www.sleekcover.com/covers/just-live-facebook-cover.jpg'),
                                fit: BoxFit.fill),
                          ),
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
                                  border: Border.all(
                                      width: 1.5, color: Colors.white),
                                  image: DecorationImage(
                                      image: snapshot.data['urlProfile'] == null
                                          ? AssetImage('images/app_logo.png')
                                          : NetworkImage(
                                              snapshot.data['urlProfile']))),
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
                    '${snapshot.data['name']} ${snapshot.data['surname']}',
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfile()));
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
                        Text(
                            'ສະຖານະ: ${snapshot.data['relationship'] == null ? 'ບໍ່ໄດ້ກຳນັດ' : snapshot.data['relationship']}'),
                        Divider(),
                        Text('ວັນເດືອນປີເກີດ:  ${snapshot.data['birthDay']}'),
                        Divider(),
                        Text('ຄຳອະທິບາຍ:Workout Work body'),
                        Divider(),
                        Text('Level:Basic'),
                        Divider(),
//                    Expanded(
//                      child: Container(),
//                    ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    ));
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
                      setCoverProfile();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setCoverProfile() {
    users.uploadImageToStorage(fileCover);
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

  void setProfile() {
    users.uploadImageToStorage(fileProfile);
  }
}
