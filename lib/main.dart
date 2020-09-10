import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/babsorptharm/recommendIntermediate.dart';
import 'package:fitfunction/babsorptharm/sorptharm1.dart';
import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:fitfunction/screens/homePages/menuPages/menu_page.dart';
import 'package:fitfunction/screens/homePages/profiles/profile_page.dart';
import 'package:fitfunction/screens/homePages/profiles/view_profile.dart';
import 'package:fitfunction/screens/homePages/workoutPage/createPlan_page.dart';
import 'package:fitfunction/screens/homePages/workoutPage/workout_page.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:fitfunction/screens/switchPage.dart';
import 'package:flutter/material.dart';

import 'babsorptharm/recommendAdvance.dart';

main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BoonHome',
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}
