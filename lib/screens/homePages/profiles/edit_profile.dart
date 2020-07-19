import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: MyBackButton(),
              ),
              Center(
                child: Text(
                  'ແກ້ໄຂໂປຣຟາຍ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
