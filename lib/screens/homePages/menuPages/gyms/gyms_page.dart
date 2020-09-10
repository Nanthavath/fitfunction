import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/gyms_detail_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class GymPage extends StatefulWidget {
  @override
  _GymPageState createState() => _GymPageState();
}

double scoreOfReview = 0.0;

class _GymPageState extends State<GymPage> {
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
                    width: 30,
                  ),
                  Text(
                    'ສູນອອກກຳລັງກາຍ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('Gyms').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgress(
                          title: 'ກຳລັງໂຫຼດ...',
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot snapGym =
                              snapshot.data.documents[index];

                          List<String> option =
                              List.from(snapGym.data['option']);
                          return Container(
                            child: InkWell(
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      margin: EdgeInsets.only(right: 10),
                                      child: CachedNetworkImage(
                                        imageUrl: snapGym.data['profileImg'],
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapGym.data['promotion'] != null
                                              ? 'On Promotion'
                                              : '',
                                          style: TextStyle(
                                            backgroundColor: Colors.green,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapGym.data['name'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text('${option[0]}'),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text('${option[1]}'),
                                        ),

                                        ///=======================================================================
                                        ///Snap Score Review
                                        Container(
                                          child: StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('ReviewGym')
                                                .where('gymID',
                                                    isEqualTo:
                                                        snapGym.documentID)
                                                .snapshots(),
                                            builder: (context, snapScore) {
                                              if (snapScore.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgress(
                                                  title: 'Loading',
                                                );
                                              }
                                              DocumentSnapshot snap;
                                              var ratingScore;
                                              int lengthOfReview = snapScore
                                                      .data.documents.length *
                                                  5;
                                              double score = 0.0;
                                              List.generate(
                                                snapScore.data.documents.length,
                                                (index) {
                                                  snap = snapScore
                                                      .data.documents[index];
                                                  ratingScore =
                                                      snap.data['score'];
                                                  score += double.tryParse(
                                                      ratingScore.toString());
                                                  scoreOfReview =
                                                      ((score * 100) /
                                                              lengthOfReview) /
                                                          10;
                                                },
                                              );

                                              return Text(
                                                '${scoreOfReview.toStringAsFixed(2).toString()}/10',
                                                style: TextStyle(
                                                    backgroundColor:
                                                        Colors.green,
                                                    color: Colors.white),
                                              );
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            Text(snapGym.data['location'])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => GymsDetail(
                                        snapGym.documentID, scoreOfReview),
                                  ),
                                );
                                print(option[0]);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
