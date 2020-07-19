import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/material.dart';


class SwitchPage extends StatefulWidget {
  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//class SwitchPage extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//  return switchPage()==null?LoginPage():HomePage();
//
//  }

  Future<String> switchPage() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }
//}
