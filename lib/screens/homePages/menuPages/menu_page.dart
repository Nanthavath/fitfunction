import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/homePages/menuPages/exercises/exercises_page.dart';
import 'package:fitfunction/screens/homePages/menuPages/favorite_page.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/gyms_page.dart';
import 'package:fitfunction/screens/homePages/menuPages/save_page.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final foods = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Text(
            'Food',
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
    final excercises = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Stack(
            children: [
              Center(
                  child: Image.asset(
                'images/basic.png',
                fit: BoxFit.contain,
              )),
              Text(
                'ທ່າອອກກຳລັງກາຍ',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ExercisePage()));
      },
    );
    final gymButton = InkWell(
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 90,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('images/gym_icon.png'),
                ),
              ),
              Text(
                'ສູນອອກກຳລັງກາຍ',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  width: 50,
                  image: AssetImage('images/favorite.png'),

                ),
              ),
              Text(
                'ລາຍການທີມັກ',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  width: 40,
                  height: 40,

                  image: AssetImage('images/save_icon.png'),

                ),
              ),
              Text(
                'ລາຍການທີບັນທຶກ',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
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
      backgroundColor: Colors.black87,
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
            Row(
              children: [
                Expanded(child: excercises),
                foods,
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                child: Text('ອອກຈາກລະບົບ'),
                onPressed: () {
                  signOut().then((value) {
                    CircularProgress(
                      title: 'ກຳລັງອອກຈາກລະບົບ',
                    );
                  });
                },
              ),
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
