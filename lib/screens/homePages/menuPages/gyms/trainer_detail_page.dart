import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainerDetail extends StatefulWidget {
  String trainerID;
  String name;

  TrainerDetail(this.trainerID, this.name);

  @override
  _TrainerDetailState createState() => _TrainerDetailState(trainerID, name);
}

class _TrainerDetailState extends State<TrainerDetail> {
  String trainerID;
  String name;

  _TrainerDetailState(this.trainerID, this.name);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Trainer')
          .document(trainerID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgress(
            title: 'ກຳລັງໂຫຼດ...',
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('ຂໍ້ມູນລາຍລະອຽດ'),
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: CachedNetworkImage(
                  width: 200,
                  height: 200,
                  imageUrl: snapshot.data['profile'],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text(snapshot.data['phone']),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Text(snapshot.data['email']),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Icon(Icons.info),
                        Text(
                          '  ກ່ຽວກັບ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(snapshot.data['about']),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.accessibility),
                        Text(
                          '  ທັກສະ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(snapshot.data['skill'].length,
                            (index) {
                          List skill = snapshot.data['skill'];
                          return Container(
                            child: Text('${index + 1}  ' + skill[index]),
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.description),
                        Text(
                          '  ປະສົບການ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 10,bottom: 20),
                      child: Text(snapshot.data['experience']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
