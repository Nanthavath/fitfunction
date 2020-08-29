import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/gyms_detail_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class GymPage extends StatefulWidget {
  @override
  _GymPageState createState() => _GymPageState();
}

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
                    'GYM',
                    style: TextStyle(
                      fontSize: 35,
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
                      if (!snapshot.hasData) {
                        return CircularProgress(
                          title: 'ກຳລັງໂຫຼດ...',
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot snapGym =
                              snapshot.data.documents[index];
                          return Container(
                            child: InkWell(
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.network(
                                        snapGym.data['profileimg'],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'On Promotion',
                                          style: TextStyle(
                                            backgroundColor: Colors.green,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapGym.data['gymname'],
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
                                          child: Text('Boxing class'),
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
                                          child: Text('Shower room'),
                                        ),
                                        Text(
                                          '8.0/10',
                                          style: TextStyle(
                                              backgroundColor: Colors.green,
                                              color: Colors.white),
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
                                    builder: (context) => GymsDetail(snapGym.documentID),
                                  ),
                                );
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
