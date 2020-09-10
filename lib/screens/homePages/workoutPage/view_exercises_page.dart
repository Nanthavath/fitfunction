

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewExercisesPage extends StatefulWidget {
  String dayID;
  String workID;

  ViewExercisesPage(this.dayID, this.workID);

  @override
  _ViewExercisesPageState createState() =>
      _ViewExercisesPageState(dayID, workID);
}

class _ViewExercisesPageState extends State<ViewExercisesPage> {
  String dayID;
  String workID;
List exID;
  _ViewExercisesPageState(this.dayID, this.workID);

  // String workoutID;
  // String day;
  // int exercisesCount;
  // List exercisesID;

  // _ViewExercisesPageState(this.workoutID, this.day, this.exercisesCount,
  //     this.exercisesID);

  @override
  void initState() {
    getExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('Workout')
              .document(workID)
              .collection('days')
              .snapshots(),
          builder: (context, snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return CircularProgress(
                title: 'ກຳລັງໂຫຼດ...',
              );
            }
            // List.generate(length, (index) => null)
            exID=List();
            String ex="";
            for(DocumentSnapshot d in snapshot1.data.documents){
             if(d.documentID==dayID){
             for(var e in d.data.values){
               // print(e);
               exID=e;
             }
             }
            }


            return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyBackButton(),
                    Expanded(
                        child: ListView(
                          children: [
                            Card(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' $dayID',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/dumbbell.png',
                                          width: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${exID.length.toString()}',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.orange),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
                                        children: List.generate(exID.length, (index2) {
                                            return StreamBuilder(
                                              stream: Firestore.instance.collection('Exercises').document(exID[index2]).snapshots(),
                                              builder: (context, snapshot2) {
                                                if (!snapshot2.hasData) {
                                                  return Container();
                                                }
                                                return Container(
                                                  child: Card(
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: NetworkImage(snapshot2.data['urlImage']),
                                                      ),
                                                      title: Text(snapshot2.data['name']),

                                                    ),
                                                  ),
                                                );
                                              },);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Future<void> getExercises() async {
   // print(workID);
    await Firestore.instance
        .collection('workout')
        .document(workID)
        .get()
        .then((value) {
      //print(value.data);
    });
  }
}
