import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/gyms_detail_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

import 'gyms/gyms_page.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  MyBackButton(),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Favorite ',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('Favorites')
                    .where('userID', isEqualTo: currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgress(
                      title: 'ກຳລັງໂຫຼດ...',
                    );
                  }
                  if (snapshot.data == null) {
                    return Container();
                  }

                  ///================ Snapshot data Gym
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot snapFavorite =
                            snapshot.data.documents[index];
                        return StreamBuilder(
                          stream: Firestore.instance
                              .collection('Gyms')
                              .document(snapFavorite.data['gymID'])
                              .snapshots(),
                          builder: (context, snapGym) {
                            if (snapGym.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgress(
                                title: 'ກຳັລງໂຫຼດ...',
                              );
                            }
                            return Container(
                              height: 150,
                              child: InkWell(
                                child: Card(
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: snapGym.data['profileImg'],
                                        width: 120,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapGym.data['name']}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text('${snapGym.data['location']}')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GymsDetail(
                                        snapFavorite.data['gymID'],
                                        scoreOfReview),
                                  ));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
