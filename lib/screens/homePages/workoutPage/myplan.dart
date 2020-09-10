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

  // Map<Object, Object> getDays = new Map();
  // Map<String, Object> getExercises = new Map();
  // List<int> lenhtOfEx = [];

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
                // var doc = snapshot.data['days'].d;
                // print(doc);
                // Stream<QuerySnapshot> ds = Firestore.instance
                //     .collection('Workout')
                //     .document(workoutID)
                //     .collection('days')
                //     .snapshots();
                // ds.forEach((element) {
                //
                //   print(element.documents.toString());
                // });
                // getDays = snapshot.data['days'];
                // lenhtOfEx = [];
                // if(getDays!=null){
                //   getDays.forEach((key, value) {
                //     getExercises = value;
                //     getExercises.forEach((key, value1) {
                //       List my = value1;
                //       lenhtOfEx.add(my.length);
                //     });
                //   });
                // }

//                print(lenhtOfEx)
                ///====================================================================GetDay

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
                              sharePlan().then((value) =>
                                  successDialog(context, 'ສຳເລັດແລ້ວ'));
                              Navigator.pop(context);
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
                                'ລະດັບ: ${snapshot.data['level']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'ຈຳນວນມື້: ${snapshot.data['dayPerWeek']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'ປະເພດ: ${snapshot.data['type']}',
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
                    Container(
                      child: StreamBuilder(
                        stream: Firestore.instance.collection('Workout').document(workoutID).collection('days').snapshots(),
                        builder: (context, snaSubDocument) {
                          if (!snaSubDocument.hasData) {
                            return Container();
                          }
                          return Column(
                            children: List.generate(snaSubDocument.data.documents.length, (index) {

                              DocumentSnapshot snap=snaSubDocument.data.documents[index];

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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    PopupMenuButton(
                                        onSelected: (value) {
                                          value = 1;
                                          deleteDay(snap.documentID).then((value){
                                            Scaffold.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'ລຶບສຳເລັດແລ້ວ',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.red),
                                                  textAlign: TextAlign
                                                      .center,
                                                ),
                                              ),
                                            );
                                          });

                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 1,
                                            child: Icon(Icons.delete,color: Colors.red,),
                                          ),
                                        ])
                                  ],
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
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
    await Firestore.instance.collection('Workout').document(workoutID).collection('days').document(day).delete();

  }

  Future<void> sharePlan() async {
    await Firestore.instance.collection('SharePlan').document().setData({
      'workoutID': workoutID,
      'userID': currentUser.uid,
      'timestamp': Timestamp.now(),
    });
  }
}
