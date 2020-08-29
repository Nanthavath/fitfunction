import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class TrainerPage extends StatefulWidget {
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

String gymID;

class _TrainerPageState extends State<TrainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  MyBackButton(),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Trainer',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                stream: Firestore.instance
                    .collection('Trainer')
                    .where('gymID', isEqualTo: gymID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgress(
                      title: 'ກຳລັງໂຫຼດ...',
                    );
                  }
                  return Container();
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
