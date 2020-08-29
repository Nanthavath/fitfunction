import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';

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
                    .collection('Favorite')
                    .where('userID', isEqualTo: currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  if (snapshot.data == null) {
                    return Container();
                  }
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
                          builder: (context, snapWorkout) {
                            if (!snapWorkout.hasData) {
                              return Container();
                            }
                            return Container(
                                height: 150,
                                child: Card(
                                    child: Row(
                                  children: [
                                    Image.network(
                                        snapWorkout.data['profileimg'],width: 150,),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${snapWorkout.data['gymname']}',style: TextStyle(fontSize: 20),),
                                          Text('Location')

                                        ],
                                      ),
                                    ),
                                  ],
                                )));
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
