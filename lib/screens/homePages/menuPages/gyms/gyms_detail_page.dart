import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/review_model.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/trainer_page.dart';
import 'package:fitfunction/screens/homePages/postPages/post_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:fitfunction/widgets/timer_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class GymsDetail extends StatefulWidget {
  String gymID;
  double scores;

  GymsDetail(this.gymID, this.scores);

  @override
  _GymsDetailState createState() => _GymsDetailState(gymID, scores);
}

PageController pageController;
bool favorite = false;
double rating = 0.0;
ReviewModel _model = ReviewModel();
List gymImage = [];

class _GymsDetailState extends State<GymsDetail> {
  String gymID;
  double scores;
  TextEditingController commentController = TextEditingController();

  _GymsDetailState(this.gymID, this.scores);

  Text txt;
  TextEditingController controllerReview;

  @override
  void initState() {
    super.initState();
    //calculateRate();

    // getReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream:
              Firestore.instance.collection('Gyms').document(gymID).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            //gymImage.add(snapshot.data['photo']);
            gymImage = snapshot.data['photo'];

            return ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        child: SizedBox(
                          height: 200.0,
                          child: CarouselSlider(
                            options: CarouselOptions(height: 400),
                            items: gymImage.map((i) {
                              return Builder(
                                builder: (context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: CachedNetworkImage(
                                      imageUrl: i,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: MyBackButton(),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('Favorites')
                                  .where('gymID', isEqualTo: gymID)
                                  .where('userID', isEqualTo: currentUser.uid)
                                  .snapshots(),
                              builder: (context, snapFavorite) {
                                if (!snapFavorite.hasData) {
                                  return Container();
                                }
                                if (snapFavorite.data.documents.length < 1) {
                                  return Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: 40,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {
                                        addToFavorite().then((value) {
                                          print('Added to Favorite');
                                        });
                                      },
                                    ),
                                  );
                                }
                                final specificDocument =
                                    snapFavorite.data.documents.where((f) {
                                  return f == null
                                      ? null
                                      : f.documentID == gymID;
                                }).toList();
                                //print(specificDocument[0]['userID'].toString());

                                return Container(
                                  child: InkWell(
                                    child: specificDocument[0]['userID'] == null
                                        ? Icon(Icons.favorite_border)
                                        : specificDocument[0]['userID']
                                                .contains(currentUser.uid)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.orange,
                                                size: 40,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                size: 40,
                                              ),
                                    onTap: () {
                                      setState(() {
                                        if (specificDocument[0]['userID']
                                            .contains(currentUser.uid)) {
                                          removeFromFavorite().then((value) {
                                            print('removed to Favorite');
                                          });
                                        } else {
                                          addToFavorite().then((value) {
                                            print('Added to Favorite');
                                          });
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '  ${scores.toStringAsFixed(2).toString()}/10',
                  style: TextStyle(fontSize: 18, backgroundColor: Colors.green),
                ),
                Text(
                  '  ${snapshot.data['name']}',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Text(' ${snapshot.data['day']} ${snapshot.data['time']}'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Text('${snapshot.data['tel']}'),
                  ],
                ),
                Container(
                  child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('Trainer').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 1.3),
                        child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  '${snapshot.data.documents.length.toString()}'),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TrainerPage()));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ໂປຣໂມຊັນ',
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
                        child: Text('${snapshot.data['promotion']}'),
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
                        'ສະແດງຄວາມຄິດເຫັນ',
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
                      if (value == null) {
                        rating = 1;
                      } else {
                        rating = value;
                        _model.score = rating;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(hintText: 'ຂໍ້ຄວາມ'),
                          ),
                        ),
                        InkWell(
                          child: Icon(Icons.send),
                          onTap: () {
                            //_showDialog();
                            if (rating == 0.0 || commentController.text == '') {
                              WarningAlertBox(
                                title: 'ຄຳເຕືອນ',
                                context: context,
                                messageText: 'ກະລຸນາໃຫ້ຄະແນນ ແລະ ຄວາມຄິດເຫັນ',
                                buttonText: 'ປິດ',
                              );
                            } else {
                              _model.comment = commentController.text;
                              _model.gymID = gymID;
                              _model.addComment().then(
                                (value) {
                                  setState(() {
                                    CircularProgress(
                                      title: 'hhhh',
                                    );
                                    rating = 0.0;
                                  });
                                },
                              );
                            }
                          },
                        )
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('ReviewGym')
                        .where('gymID', isEqualTo: gymID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: List.generate(
                              snapshot.data.documents.length, (index) {
                            DocumentSnapshot snapReview =
                                snapshot.data.documents[index];
                            return StreamBuilder(
                              stream: Firestore.instance
                                  .collection('Users')
                                  .document(snapReview.data['userID'])
                                  .snapshots(),
                              builder: (context, snapUserInfo) {
                                if (!snapUserInfo.hasData) {
                                  return Container();
                                }
                                if (snapUserInfo.data == null) {
                                  return Container();
                                } else {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                snapUserInfo
                                                    .data['urlProfile']),
                                      ),
                                      title: Text(
                                          '${snapUserInfo.data['name']} ${snapUserInfo.data['surname']}'),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${snapReview.data['score']}: ${TimerCurrent().readTimestamp(snapReview.data['timestamp'])}'),
                                            Text(
                                                '${snapReview.data['comment']}'),
                                          ]),
                                      trailing: PopupMenuButton(
                                        onSelected: (value) {
                                          value = 1;
                                          deleteComment(snapReview.documentID)
                                              .then((value) =>
                                                  print('Delete Complete'));
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
                                    ),
                                  );
                                }
                              },
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteComment(String commentID) async {
    await Firestore.instance
        .collection('ReviewGym')
        .document(commentID)
        .delete();
  }

  Future<void> addToFavorite() async {
    Timestamp timestamp = Timestamp.now();
    print(gymID);
    print(currentUser.uid);
    await Firestore.instance.collection('Favorites').document(gymID).setData({
      'gymID': gymID,
      'userID': currentUser.uid,
      'timestamp': timestamp,
    });
  }

  Future<void> removeFromFavorite() async {
    await Firestore.instance.collection('Favorites').document(gymID).delete();
  }
}
