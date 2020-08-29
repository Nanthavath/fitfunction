import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';

class ViewExercisesPage extends StatefulWidget {
  String workoutID;
  String day;
  int exercisesCount;
  List exercisesID;

  ViewExercisesPage(this.workoutID, this.day, this.exercisesCount,
      this.exercisesID);

  @override
  _ViewExercisesPageState createState() =>
      _ViewExercisesPageState(workoutID, day, exercisesCount, exercisesID);
}

class _ViewExercisesPageState extends State<ViewExercisesPage> {
  String workoutID;
  String day;
  int exercisesCount;
  List exercisesID;


  _ViewExercisesPageState(this.workoutID, this.day, this.exercisesCount,
      this.exercisesID);

@override
  void initState() {
 getExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                                Text('$day'),
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
                                      '$exercisesCount',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.orange),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Column(
                                    children: List.generate(1, (index) {
                                      return Card(
                                        child: ListTile(
                                          leading: CircleAvatar(),
                                          title: Text('Exercises name'),
                                          subtitle: Text('2 set'),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )),
      ),
    );
  }

  Future<List> getExercises() async {
  List obj=[];
  for(int i=0;i<exercisesCount;i++){
    await Firestore.instance.collection('Exercises').document(exercisesID[i]).snapshots();
    //print(object)
  }
return obj;
  }
}
