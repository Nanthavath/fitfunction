import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';
class GymPage extends StatefulWidget {
  @override
  _GymPageState createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackButton(),
    );
  }
}
