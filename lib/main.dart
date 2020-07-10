import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BoonHome',
        primarySwatch: Colors.orange,
      ),
      home: _authentication.currentUser() != null ? HomePage() : LoginPage(),
    );
  }
}
