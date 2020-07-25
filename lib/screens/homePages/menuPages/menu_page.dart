import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/homePages/menuPages/favorite_page.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms_page.dart';
import 'package:fitfunction/screens/homePages/menuPages/save_page.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final gymButton = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Text(
            'GYM',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GymPage()));
      },
    );
    final favoriteButton = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Text(
            'Favorite',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FavoritePage(),
          ),
        );
      },
    );
    final saveButton = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Text(
            'Save',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SavePage(),
          ),
        );
      },
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'ເພີ່ມເຕີມ',
                style: TextStyle(fontSize: 30, color: Colors.orange),
              ),
            ),
            gymButton,
            Row(
              children: <Widget>[
                Expanded(
                  child: favoriteButton,
                ),
                Expanded(
                  child: saveButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    FirebaseAuth _authen = FirebaseAuth.instance;
    FirebaseUser user = await _authen.currentUser();
    print(user.uid);

    Authen.signOut().then((value) {
      print(value.toString());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    });
  }
}
