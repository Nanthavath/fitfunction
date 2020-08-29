import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/workoutPage/createPlan_page.dart';
import 'package:fitfunction/screens/homePages/workoutPage/myplan.dart';
import 'package:fitfunction/screens/homePages/workoutPage/view_workout_page.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final sharePlan = StreamBuilder(
      stream: Firestore.instance.collection('SharePlan').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data == null) {
          return Container();
        }else{
          return Column(
            children: List.generate(snapshot.data.documents.length, (index) {
              DocumentSnapshot snapShare = snapshot.data.documents[index];
              return StreamBuilder(
                stream: Firestore.instance
                    .collection('Workout')
                    .document(snapShare.data['workoutID'])
                    .snapshots(),
                builder: (context, snapWorkout) {
                  if (!snapWorkout.hasData) {
                    return Container();
                  } else if (snapWorkout.data == null) {
                    return Container();
                  }else{
                    return StreamBuilder(
                      stream: Firestore.instance
                          .collection('Users')
                          .document(snapShare.data['userID'])
                          .snapshots(),
                      builder: (context, snapUserInfo) {
                        if (!snapUserInfo.hasData) {
                          return Container();
                        }
                        return Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                NetworkImage(snapUserInfo.data['urlProfile']),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(snapWorkout.data['workoutName']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(TimerCurrent()
                                      .readTimestamp(snapShare.data['timestamp'])),
                                  Text(
                                      '${snapUserInfo.data['name']} ${snapUserInfo.data['surname']}'),
                                  Text('Level: ${snapWorkout.data['level']}'),
                                  Text('Type: ${snapWorkout.data['type']}'),
                                ],
                              ),
                              trailing: InkWell(
                                child: Icon(Icons.favorite_border),
                                onTap: () {},
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ViewWorkoutPage(
                                        snapUserInfo.data['name'],
                                        snapUserInfo.data['surname'],
                                        snapUserInfo.data['urlProfile'],
                                        snapShare.data['workoutID']),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }

                },
              );
            }),
          );
        }

      },
    );
    final favoriteLis = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Image.asset(
                        'images/person.png',
                        width: 20,
                      ),
                      title: Text(
                        'My Plan$index',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(
                        Icons.favorite,
                        color: Colors.orange,
                      )),
                  Text('Level: Beginning'),
                  Text('Type: Beginning'),
                ],
              ),
            ),
          ),
          onTap: () {
//            Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => ViewWorkoutPage()));
          },
        );
      },
    );
    final createButton = Align(
      alignment: Alignment.topRight,
      child: RaisedButton.icon(
        elevation: 1,
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(5),
        icon: Icon(
          Icons.add,
          color: Colors.orange,
        ),
        label: Text('ສ້າງແຜນໃຫມ່'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreatePlan()));
        },
      ),
    );

    final searchText = SizedBox(
      height: 35,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'ຄົ້ນຫາ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              32.0,
            ),
            borderSide: BorderSide(width: 1),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
        ),
      ),
    );
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: StreamBuilder(
          stream: Firestore.instance.collection('Workout').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgress(
                title: 'ກຳລັງໂຫຼດ...',
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                searchText,
                createButton,
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot snapWorkout =
                          snapshot.data.documents[index];
                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('Users')
                            .document(snapWorkout.data['userID'])
                            .snapshots(),
                        builder: (context, snapUserInfo) {
                          if (!snapUserInfo.hasData) {
                            return Container();
                          }
                          return InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 3,
                              child: Container(
                                margin: EdgeInsets.all(3),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${snapUserInfo.data['urlProfile']}'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        title: Text(
                                          '${snapWorkout.data['workoutName']}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        trailing: Icon(Icons.more_vert)),
                                    Text('Level: ${snapWorkout.data['level']}'),
                                    Text('Type: ${snapWorkout.data['type']}'),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MyPlanPage(
                                      snapWorkout.documentID,
                                      snapWorkout.data['workoutName'],
                                      snapUserInfo.data['urlProfile']),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 120,
                  child: favoriteLis,
                ),
                Expanded(child: sharePlan),
              ],
            );
          },
        ),
      ),
    );
  }
}
