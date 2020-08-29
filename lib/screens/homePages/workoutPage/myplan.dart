import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:flutter/material.dart';

class MyPlanPage extends StatefulWidget {
  String workoutID;
  String workoutName;
  String urlProfile;

  MyPlanPage(this.workoutID, this.workoutName, this.urlProfile);

  @override
  _MyPlanPageState createState() =>
      _MyPlanPageState(workoutID, workoutName, urlProfile);
}

class _MyPlanPageState extends State<MyPlanPage> {
  String workoutID;
  String workoutName;
  String urlProfile;
  Map<Object, Object> getDays = new Map();
  Map<String, Object> getExercises = new Map();
  List<int> lenhtOfEx = [];

  _MyPlanPageState(this.workoutID, this.workoutName, this.urlProfile);

  String profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('My Plan'),
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            StreamBuilder(
              stream: Firestore.instance
                  .collection('Workout')
                  .document(workoutID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                getDays = snapshot.data['days'];
                lenhtOfEx = [];
                getDays.forEach((key, value) {
                  getExercises = value;
                  getExercises.forEach((key, value1) {
                    List my = value1;
                    lenhtOfEx.add(my.length);
                  });
                });
//                print(lenhtOfEx);
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(left: 20),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.orange,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          '$workoutName',
                          style: TextStyle(fontSize: 30),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.orange,
                              size: 40,
                            ),
                            onPressed: () {
                              sharePlan()
                                  .then((value) => successDialog(context, 'ສຳເລັດແລ້ວ'));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // border:
                            //     Border.all(color: AppColors.Yellow_COLOR, width: 2.0)),
                          ),
                          child: ClipOval(
                            child: Container(
                                height: 105,
                                width: 105,
                                color: Colors.grey[200],
                                child: urlProfile == null
                                    ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : Image.network(
                                        urlProfile,
                                        fit: BoxFit.contain,
                                        loadingBuilder: (context, child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      )),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 105,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Level: ${snapshot.data['level']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'Routine: ${snapshot.data['dayPerWeek']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'Type: ${snapshot.data['type']}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data['description']}',
                              style: TextStyle(fontSize: 23),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(getDays.keys.length, (index) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          height: 110,
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${getDays.keys.toList() == null ? 0 : getDays.keys.toList()[index]}',
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
                                        ' ${lenhtOfEx[index]}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              PopupMenuButton(
                                  onSelected: (value) {
                                    value = 1;

                                    deleteDay(getDays.keys.toList()[index]);
//                                    print(getDays.keys.toList()[index]);
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text('Delete'),
                                        ),
                                      ])
                            ],
                          ),
                        );
                      }),
                    ),
//                  ListView.builder(
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    itemCount: 5,
//                    itemBuilder: (context, index) {
//                     // DocumentSnapshot snapDetail=snapshot.data.documents[index];
//
//                    },
//                  )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteDay(String day) async {
//    Map<Object,Object> del=new Map();
//    del['days']=day;
    print(day);
    await Firestore.instance
        .collection('Workout')
        .document(workoutID)
        .updateData({
      'days': FieldValue.arrayRemove([day])
    }).whenComplete(() {
      print('Field Deleted');
    });

  }

  Future<void> sharePlan() async {
    await Firestore.instance.collection('SharePlan').document().setData({
      'workoutID': workoutID,
      'userID': currentUser.uid,
      'timestamp': Timestamp.now(),
    });
  }
}
