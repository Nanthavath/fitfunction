
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/screens/homePages/menuPages/exercises/exercises_detail_page.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

List<String> bodyPart = [
  'Back',
  'Chest',
  'Biceps',
  'Triceps',
  'Shoulders',
  'Abs',
  'Upper Leg',
  'Lower Leg'
];
List listBody=[];

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excercises'),
        actions: [
          FlatButton(
            child: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Body part',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              //color: Colors.orange,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width:252<MediaQuery.of(context).size.width?MediaQuery.of(context).size.width:252 ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  List.generate(bodyPart.length-4, (index) {
                          return ChoiceChip(
                            label: Text(bodyPart[index]),
                            labelStyle: TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            selected: false,
                            backgroundColor: Color(0xffededed),
                            onSelected: (isSelected) {
                              setState(
                                    () {},
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  List.generate(bodyPart.length-4, (index) {
                      return ChoiceChip(
                        label: Text(bodyPart[index+4]),
                        labelStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        selected: false,
                        backgroundColor: Color(0xffededed),
                        onSelected: (isSelected) {
                          setState(
                                () {},
                          );
                        },
                      );
                    }),
                  ),
                ],
              )
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: Firestore.instance.collection('Exercises').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState==ConnectionState.waiting) {
                      return CircularProgress(
                        title: 'ກຳລັງໂຫຼດ...',
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapExercises =
                        snapshot.data.documents[index];
                        listBody=snapExercises.data['type'];
                        print(listBody.toString());
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapExercises.data['urlImage']),
                              ),
                              title: Text(snapExercises.data['name']),
                              //subtitle: Text('${listBody.toList().toString().replaceAll('[', '').replaceAll(']', '')}'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ExcercisesDetail(snapExercises.data['name'],snapExercises.data['urlImage'],snapExercises.data['description'])));
                              },
                            ),
                            Divider(thickness: 1,),
                          ],
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
    );
  }
}
