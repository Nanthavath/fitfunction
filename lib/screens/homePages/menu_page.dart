import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          child: Text('SignOut'),
          onPressed: () async {
            FirebaseAuth _authen = FirebaseAuth.instance;
            FirebaseUser user = await _authen.currentUser();
            print(user.uid);

            Authen.signOut().then((value) {
              print(value.toString());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            });
          },
        ),
      ),
    );
  }
}
