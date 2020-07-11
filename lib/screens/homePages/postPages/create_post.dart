import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/buttonLabel.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildPost extends StatefulWidget {
  @override
  _BuildPostState createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  String urlProfile =
      'https://firebasestorage.googleapis.com/v0/b/fitfunction-8d4d1.appspot.com/o/profiles%2Fprofile.png?alt=media&token=36c01c8f-4ca4-41d5-ac93-b771d9410263';

  Widget takePhoto() {
    return ButtonLabel(
      title: 'ຖ່າຍຮູບ',
      icon: Icon(Icons.photo_camera,size: 40,),
      onPressed: () {},
    );
  }

  Widget pickPhoto() {
    return ButtonLabel(
      title: 'ເລືອກຮູບພາບ',
      icon: Icon(Icons.photo,size: 40,),
      onPressed: () {},
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
                        height: 400,
                        child: Column(
                          children: <Widget>[
                            circleAvatars(),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Image.asset('images/cats.jpg',
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
