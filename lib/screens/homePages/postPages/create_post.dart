import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/material.dart';

class BuildPost extends StatefulWidget {
  @override
  _BuildPostState createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  String urlProfile =
      'https://firebasestorage.googleapis.com/v0/b/fitfunction-8d4d1.appspot.com/o/profiles%2Fprofile.png?alt=media&token=36c01c8f-4ca4-41d5-ac93-b771d9410263';

  Widget circleAvatars() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(urlProfile),
        backgroundColor: Colors.transparent,
      ),
      title: SizedBox(
        height: 30,
        child: SizedBox(
          height: 100,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What is on your mind?',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    leading: MyBackButton(),
                    title: Text(
                      'ສ້າງໂພສໃຫມ່',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 1,
                    child: Column(
                      children: <Widget>[circleAvatars(),
                      Container(
                        height: 420,
                      )],
                    ),
                  ),
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
