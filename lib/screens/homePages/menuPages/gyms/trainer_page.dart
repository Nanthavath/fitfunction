import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/menuPages/gyms/trainer_detail_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class TrainerPage extends StatefulWidget {
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

String gymID;
List skill=[];

class _TrainerPageState extends State<TrainerPage> {
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
                    width: 25,
                  ),
                  Text(
                    'ເທຣນເນີ',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                stream: Firestore.instance
                    .collection('Trainer')
                    .where('gymID', isEqualTo: gymID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgress(
                      title: 'ກຳລັງໂຫຼດ...',
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapTrainer =
                            snapshot.data.documents[index];
                        skill=snapTrainer.data['skill'];

                        return Container(
                          child: InkWell(
                            child: Card(
                              child: Container(
                                height: 150,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: Image(
                                          image: NetworkImage(
                                              snapTrainer.data['profile']),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapTrainer.data['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('ທັກສະ:'),
                                            Text('1. '+skill[0].toString()),
                                            Text('2. '+skill[1].toString()),
                                            Text('3. '+skill[2].toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainerDetail(snapTrainer.documentID,snapTrainer.data['name']),));
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
