import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

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
