import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/homePages/profiles/edit_profile.dart';
import 'package:fitfunction/screens/homePages/profiles/view_profile.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File fileCover;
  File fileProfile;
  File picked;
  final picker = ImagePicker();
  Users users = Users();

  Future<void> choosePictureCover(ImageSource imageSource) async {
    try {
      picked = File((await picker.getImage(source: imageSource)).path);
      _croppedImageCover();
    } catch (ex) {}
  }

  Future<void> _croppedImageCover() async {
    File cropFile = await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              //CropAspectRatioPreset.square,
              //CropAspectRatioPreset.ratio3x2,

              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              //CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              //CropAspectRatioPreset.ratio5x3,
              //CropAspectRatioPreset.ratio5x4,
              //CropAspectRatioPreset.ratio7x5,
              //CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ),
    );
    if (cropFile != null) {
      setState(() {
        fileCover = cropFile;
      });
      setCoverProfile();
    }
  }

  Future<void> choosePictureProfile(ImageSource imageSource) async {
    try {
      File object = File((await picker.getImage(source: imageSource)).path);
      // setState(() {
      //   fileProfile = object;
      //   //setProfile();
      // });
      _croppedProfile(object);
    } catch (ex) {}
  }

  Future<void> _croppedProfile(File file) async {
    File cropProfile = await ImageCropper.cropImage(
        sourcePath: file.path,
        androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.orange,
          toolbarColor: Colors.orange,
          toolbarTitle: 'Crop',
        ),
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        ]);
    if (cropProfile != null) {
      setState(() {
        fileProfile = cropProfile;
      });
      _setProfile(cropProfile);
    }
  }

  Future<void> _setProfile(File cropped) async {
    Random random = Random();
    int i = random.nextInt(100000);
    final StorageReference storageReference =
        FirebaseStorage().ref().child('profiles/profile$i');
    final StorageUploadTask uploadTask = storageReference.putFile(cropped);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    await Firestore.instance
        .collection('Users')
        .document(currentUser.uid)
        .updateData({
      'urlProfile': url,
    }).then((value) => print('Complete'));
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
    return FutureBuilder(
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
                          height: MediaQuery.of(context).size.height / 3.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: snapshot.data['urlCover'] != null
                                  ? NetworkImage(snapshot.data['urlCover'])
                                  : NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/fitfunction-1d97a.appspot.com/o/cover.png?alt=media&token=8d9ec91b-eb87-41bf-b95d-ab842a33b4d6'),
                            ),
                          ),
                        ),
                        onTap: () {
                          actionSheetCover(snapshot.data['urlCover']);
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
                                  image: snapshot.data['urlProfile'] != null
                                      ? NetworkImage(
                                          snapshot.data['urlProfile'])
                                      : AssetImage('images/app_logo.png'),
                                ),
                              ),
                            ),
                            onTap: () {
                              //actionSheetModel();
                              actionSheetProfile(snapshot.data['urlProfile']);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${snapshot.data['name']} ${snapshot.data['surname']}',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        //color: Colors.red,
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange)
                            // color: Colors.red
                            ),
                        child: InkWell(
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.orange,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfile()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'ຂໍ້ມູນ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.description),
                            SizedBox(
                              width: 5,
                            ),
                            Text(snapshot.data['caption'] != null
                                ? snapshot.data['caption']
                                : 'ບໍ່ໄດ້ກຳນັດ'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                ' ${snapshot.data['relationship'] == null ? 'ບໍ່ໄດ້ກຳນັດ' : snapshot.data['relationship']}'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${snapshot.data['birthDay']}'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'images/weigth.png',
                              width: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(snapshot.data['weight'] != null
                                ? snapshot.data['weight']
                                : 'ບໍ່ໄດ້ກຳນັດ'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.accessibility),
                            SizedBox(
                              width: 5,
                            ),
                            Text(snapshot.data['height'] != null
                                ? snapshot.data['height']
                                : 'ບໍ່ໄດ້ກຳນັດ'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.fitness_center),
                            SizedBox(
                              width: 5,
                            ),
                            Text(snapshot.data['level'] != null
                                ? snapshot.data['level']
                                : 'ບໍ່ໄດ້ກຳນັດ'),
                          ],
                        ),

//                    Expanded(
//                      child: Container(),
//                    ),
                        Divider(
                          thickness: 1,
                        ),
                        Text(
                          'ລາຍການທີໂພສ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('Posts')
                                .where('userID', isEqualTo: currentUser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              if (snapshot == null) {
                                return Container(
                                  child: Center(child: Text('No Data')),
                                );
                              }
                              return StreamBuilder(
                                stream: Firestore.instance
                                    .collection('Users')
                                    .document(currentUser.uid)
                                    .snapshots(),
                                builder: (context, snapUserInfo) {
                                  if (!snapUserInfo.hasData) {
                                    return Container();
                                  }
                                  return Column(
                                    children: List.generate(
                                        snapshot.data.documents.length,
                                        (index) {
                                      DocumentSnapshot snapPost =
                                          snapshot.data.documents[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      snapUserInfo
                                                          .data['urlProfile']),
                                                ),
                                                title: Text(
                                                    '${snapUserInfo.data['name']} ${snapUserInfo.data['surname']}'),
                                                subtitle: Text(TimerCurrent()
                                                    .readTimestamp(snapPost
                                                        .data['timestamp'])),
                                                trailing: PopupMenuButton(
                                                  onSelected: (value) {
                                                    if (value == 1) {
                                                      _deletePost(snapPost
                                                              .documentID)
                                                          .then(
                                                        (value) =>
                                                            Scaffold.of(context)
                                                                .showSnackBar(
                                                          SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(
                                                              'ລຶບສຳເລັດແລ້ວ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text('ລຶບ'),
                                                        ],
                                                      ),
                                                      value: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Text(snapPost
                                                      .data['caption'])),
                                              CachedNetworkImage(
                                                imageUrl:
                                                    snapPost.data['urlPhoto'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void actionSheetCover(String fileCover) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('ເບິ່ງຮູບຫນ້າປົກ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewProfile(file: fileCover,)));
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
    users.uploadImageToStorage(fileCover).then((value) {
      setState(() {
        CircularProgress(
          title: 'Uploading...',
        );
      });
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

  void actionSheetProfile(String profile) {
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
                            file: profile,
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

  Future<void> _deletePost(String postID) async {
    await Firestore.instance.collection('Posts').document(postID).delete();
  }
}
