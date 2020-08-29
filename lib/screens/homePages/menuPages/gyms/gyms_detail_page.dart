import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/review_model.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/trainer_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class GymsDetail extends StatefulWidget {
  String gymID;

  GymsDetail(this.gymID);

  @override
  _GymsDetailState createState() => _GymsDetailState(gymID);
}

bool favorite = false;
double rating = 0.0;
ReviewModel _model = ReviewModel();

class _GymsDetailState extends State<GymsDetail> {
  String gymID;

  _GymsDetailState(this.gymID);

  TextEditingController controllerReview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream:
              Firestore.instance.collection('Gyms').document(gymID).snapshots(),
          builder: (context, snapshot) {
            return ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Image.network(snapshot.data['profileimg']),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: MyBackButton(),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: favorite == false
                                ? Icon(
                                    Icons.favorite_border,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    size: 40,
                                    color: Colors.orange,
                                  ),
                            onTap: () {
                              setState(() {
                                if (favorite == false) {
                                  favorite = true;
                                 addFavorite();
                                } else {
                                  favorite = false;
                                }
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '  8.0/10 Excellent',
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.green,
                  ),
                ),
                Text(
                  '  Empire Fitness',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Text(' Mon-Fri 6:00-22:00'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Text('20202220'),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 1.5),
                  child: RaisedButton(
                    elevation: 0,
                    child: Row(
                      children: [
                        Icon(Icons.people),
                        Text('Trainer'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TrainerPage()));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'On Promotion',
                        style: TextStyle(
                          fontSize: 18,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Discount 20%'),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Icon(Icons.rate_review),
                      Text(
                        'Review',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Center(
                  child: SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    rating: rating,
                    size: 30,
                    isReadOnly: false,
                    filledIconData: Icons.star,
                    defaultIconData: Icons.star_border,
                    color: Colors.orange,
                    borderColor: Colors.orange,
                    spacing: 0.0,
                    onRated: (value) {
                      if(value==null){
                        rating = 1;
                      }else{
                        rating=value;
                        _model.score = rating;
                      }

                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Comment'),
                            onChanged: (value) => _model.comment = value,
                          ),
                        ),
                        InkWell(
                          child: Icon(Icons.send),
                          onTap: () {
                            _model.gymID = gymID;
                            _model
                                .addComment()
                                .then((value) => print('comment success'));
                          },
                        )
                      ],
                    )),
                StreamBuilder(
                  stream:
                      Firestore.instance.collection('ReviewGym').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    if (snapshot.data == null) {
                      return Container();
                    }
                    return Column(
                      children: List.generate(
                        snapshot.data.documents.length<=0?1: snapshot.data.documents.length,
                        (index) {
                          DocumentSnapshot snapReview =
                              snapshot.data.documents[index];
                          return StreamBuilder(
                            stream: Firestore.instance
                                .collection('Users')
                                .document(snapReview.data['userID'])
                                .snapshots(),
                            builder: (context, snapshotUserInfo) {
                              if (!snapshotUserInfo.hasData) {
                                return Container();
                              } else if (snapshotUserInfo.data == null) {
                                return Container();
                              }
                              else{
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshotUserInfo
                                        .data['urlProfile']==null
                                        ? Container()
                                        : snapshotUserInfo.data['urlProfile']),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: Text(
                                      '${snapshotUserInfo.data['name']} ${snapshotUserInfo.data['surname']}'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${snapReview.data['score']}'),
                                      Text(
                                          '${snapReview.data['comment']}: ${TimerCurrent().readTimestamp(snapReview.data['timestamp'])}'),
                                    ],
                                  ),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      value = 1;
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            Text('ລຶບ'),
                                          ],
                                        ),
                                        value: 1,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> addFavorite()async {
    await  Firestore.instance.collection('Favorite').document().setData(
        {
          'gymID':gymID,
          'userID':currentUser.uid,
          'timestamp':Timestamp.now()
        }
    ).then((value) => print('Favorite Success'));
  }
}
