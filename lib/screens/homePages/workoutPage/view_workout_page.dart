import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/screens/homePages/workoutPage/view_exercises_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
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

  // Map<Object, Object> getDays = new Map();
  // Map<String, Object> getExercises = new Map();
  // List<int> lenhtOfEx = [];
  // List<List> getExercisesID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Workout')
                .document(workoutID)
                .snapshots(),
            builder: (context, snapFavorite) {
              if (snapFavorite.connectionState == ConnectionState.waiting) {
                return CircularProgress(
                  title: 'ກຳລັງໂຫຼດ',
                );
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyBackButton(),
                      Text(
                        '$name $surname',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: snapFavorite.data['favorite']
                                .contains(currentUser.uid)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.orange,
                              )
                            : Icon(Icons.favorite_border),
                        onTap: () {
                          if (snapFavorite.data['favorite']
                              .contains(currentUser.uid)) {
                            removeFavorite(workoutID);
                          } else {
                            addFavorite(workoutID);
                          }
                        },
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
//                   getDays = snapWorkout.data['days'];
//                   lenhtOfEx = [];
//                   getExercisesID = [];
//                   getDays.forEach((key, value) {
//                     getExercises = value;
//                     getExercises.forEach((key, value1) {
//                       List my = value1;
//                       lenhtOfEx.add(my.length);
//                       getExercisesID.add(my);
// //                      print(value1);
//                     //  getExercisesID.add(my);
//                     });
//                   });
//
//                   print(getExercisesID);
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
                                  Text('ລະດັບ: ${snapWorkout.data['level']}'),
                                  Text(
                                      'ຈຳມື້:${snapWorkout.data['dayPerWeek']} ມື້/ທິດ'),
                                  Text('ປະເພດ: ${snapWorkout.data['type']}'),
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
                                  'ຄຳອະທິບາຍ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Center(
                                    child: Text(
                                        '${snapWorkout.data['description']}'))
                              ],
                            ),
                          ),

                          ///===========================================
                          Container(
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('Workout')
                                  .document(workoutID)
                                  .collection('days')
                                  .snapshots(),
                              builder: (context, snaSubDocument) {
                                if (!snaSubDocument.hasData) {
                                  return Container();
                                }
                                return Column(
                                  children: List.generate(
                                      snaSubDocument.data.documents.length,
                                      (index) {
                                    DocumentSnapshot snap =
                                        snaSubDocument.data.documents[index];
                                    return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 1,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          border: Border.all(
                                              color: Colors.black, width: 0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                        ),
                                        height: 110,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Day-${index + 1}',
                                                      style: TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${snap.documentID}',
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'images/dumbbell.png',
                                                      width: 40,
                                                    ),
                                                    Text(
                                                      ' ${snap.data['exercise'].length.toString()}',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ViewExercisesPage(
                                                  snap.documentID, workoutID),
                                        ));
                                      },
                                    );
                                  }),
                                );
                              },
                            ),
                          ),

                          ///===========================================
//                       Column(
//                         children: List.generate(snapWorkout.data.documents.length, (index) {
//                           return Container(
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: ListTile(
//                                 title: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text('${getDays.keys.toList()[index]}'),
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                           'images/dumbbell.png',
//                                           width: 40,
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         // Text('${lenhtOfEx[index]}'),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 onTap: () {
// //                                  print(getExercisesID[index]);
// //                                   Navigator.of(context).push(
// //                                     MaterialPageRoute(
// //                                       builder: (context) => ViewExercisesPage(
// //                                         workoutID,getDays.keys.toList()[index],lenhtOfEx[index],getExercisesID[index]
// //                                       ),
// //                                     ),
// //                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
                        ],
                      );
                    },
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> removeFavorite(String workID) async {
    await Firestore.instance.collection('Workout').document(workID).updateData({
      'favorite': FieldValue.arrayRemove([currentUser.uid])
    });
  }

  Future<void> addFavorite(String workID) async {
    await Firestore.instance.collection('Workout').document(workID).updateData({
      'favorite': FieldValue.arrayUnion([currentUser.uid])
    });
  }
}
