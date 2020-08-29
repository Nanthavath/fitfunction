import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/workoutPage/view_exercises_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';

class ViewWorkoutPage extends StatefulWidget {
  String name;
  String surname;
  String profile;
  String workoutID;

  ViewWorkoutPage(this.name, this.surname, this.profile, this.workoutID);

  @override
  _ViewWorkoutPageState createState() =>
      _ViewWorkoutPageState(name, surname, profile, workoutID);
}

class _ViewWorkoutPageState extends State<ViewWorkoutPage> {
  String name;
  String surname;
  String profile;
  String workoutID;

  _ViewWorkoutPageState(this.name, this.surname, this.profile, this.workoutID);

  Map<Object, Object> getDays = new Map();
  Map<String, Object> getExercises = new Map();
  List<int> lenhtOfEx = [];
  List<List> getExercisesID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyBackButton(),
                  Text(
                    '$name $surname',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.favorite_border,
                      size: 40,
                    ),
                    onTap: () {},
                  )
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                stream: Firestore.instance
                    .collection('Workout')
                    .document(workoutID)
                    .snapshots(),
                builder: (context, snapWorkout) {
                  if (!snapWorkout.hasData) {
                    return Container();
                  }
                  getDays = snapWorkout.data['days'];
                  lenhtOfEx = [];
                  getExercisesID = [];
                  getDays.forEach((key, value) {
                    getExercises = value;
                    getExercises.forEach((key, value1) {
                      List my = value1;
                      lenhtOfEx.add(my.length);
                      getExercisesID.add(my);
//                      print(value1);
                    //  getExercisesID.add(my);
                    });
                  });

                  print(getExercisesID);
                  return ListView(
                    children: [
                      Container(
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      profile,
                                    ),
                                    fit: BoxFit.contain)),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Level: ${snapWorkout.data['level']}'),
                              Text(
                                  'Routine:${snapWorkout.data['dayPerWeek']} Days/Week'),
                              Text('Type: ${snapWorkout.data['type']}'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(20),
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(fontSize: 18),
                            ),
                            Center(
                                child:
                                    Text('${snapWorkout.data['description']}'))
                          ],
                        ),
                      ),
                      Column(
                        children: List.generate(getDays.keys.length, (index) {
                          return Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${getDays.keys.toList()[index]}'),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/dumbbell.png',
                                          width: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('${lenhtOfEx[index]}'),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
//                                  print(getExercisesID[index]);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewExercisesPage(
                                        workoutID,getDays.keys.toList()[index],lenhtOfEx[index],getExercisesID[index]
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
