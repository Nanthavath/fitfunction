import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/workout_item.dart';
import 'package:fitfunction/screens/homePages/workoutPage/summary_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

import 'createPlan_page.dart';

List<WorkoutItem> summeryData = [];

class SetPlan extends StatefulWidget {
  @override
  _SetPlanState createState() => _SetPlanState();
}

List selectedActivity = [];
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

bool isCheck = false;
int dayIndex = 0;
int n = 0;
List selectedEx = [];

class _SetPlanState extends State<SetPlan> {
//  int indexOfDay(){
//
//  }
  @override
  void initState() {
    dayIndex = 0;
    n = 0;
    summeryData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchBox = SizedBox(
      height: 35,
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        cursorColor: Colors.black,
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(),
            ),
            contentPadding: EdgeInsets.only(
              top: 1,
              bottom: 1,
              right: 15,
            ),
            hintText: 'ຄົ້ນຫາ'),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyBackButton(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${workoutModel.namePlan}',
                    style: TextStyle(fontSize: 25, color: Colors.orange),
                  ),
                ],
              ),
              Text(
                '${workoutModel.selectedDayName[dayIndex]}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Center(child: searchBox),
              SizedBox(
                height: 15,
              ),
              Text('Body Part'),
              Container(
                  //color: Colors.orange,
                  child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
//                      width: 252 < MediaQuery.of(context).size.width
//                          ? MediaQuery.of(context).size.width
//                          : 252,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(bodyPart.length - 4, (index) {
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
                    children: List.generate(bodyPart.length - 4, (index) {
                      return ChoiceChip(
                        label: Text(bodyPart[index + 4]),
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
              )),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('Exercises').snapshots(),
                    builder: (context, snapshot) {
                      if (selectedActivity.length == 0) {
                        selectedActivity = List(100);
                        for (int i = 0; i < 100; i++) {
                          selectedActivity[i] = false;
                        }
                      }
                      //  print('size:${selectedActivity.length}');
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot snapExercises =
                              snapshot.data.documents[index];
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.1))),
                            child: ListTile(
//                                onTap: (){
//                                  setState(() {
////                                    isCheck=true;
////                                  if(isCheck){
////                                    selectedActivity[index]=isCheck;
////                                  }else{
////                                    selectedActivity[index]=!isCheck;
////                                  }
//
//                            print(selectedActivity[index]);
//                                  });
//
//                                },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapExercises.data['urlPhoto']),
                              ),
                              title: Text(snapExercises.data['exname']),
                              subtitle: Text('Type'),
                              trailing: ChoiceChip(
                                label: Text(' '),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                selected: selectedActivity[index],
                                backgroundColor: Color(0xffededed),
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedActivity[index] = isSelected;
//                                 print(selectedActivity[index]);
                                    //    selectedEx=[];

                                    if (isSelected) {
                                      selectedEx
                                          .add(snapExercises.documentID);
                                    } else {
                                      selectedEx
                                          .remove(snapExercises.documentID);
                                    }

//                                    print(snapExercises.data['exname']);
//                                    print(selectedEx);
                                  });
                                },
                                selectedColor: Colors.orange,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: SubmitButton(
                    title: 'ຖັດໄປ',
                    onPressed: () {
                      setState(() {
                        WorkoutItem item;
                        if (dayIndex == 0) {
                          summeryData = [];
                        }
                        if (dayIndex < workoutModel.dayPerWeek) {
                          if (selectedEx.length > 0) {
                            item = WorkoutItem(
                                workoutModel.selectedDayName[dayIndex],
                                selectedEx.toList());
                            summeryData.add(item);

                            selectedActivity = [];
                            selectedEx = [];
                          } else {
                            warningDialog(context, 'ກະລຸນາເລືອກກິດຈະກຳ');
                            return;
                          }
                          //   n++;
                          dayIndex++;
                        }
                        if (dayIndex == workoutModel.dayPerWeek) {
//                          for (int i = 0; i < summeryData.length; i++) {
//                            print(summeryData[i].selectedExercises.length);
//                            print('***************');
//                          }
                          dayIndex = 0;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SummaryPage()));
                        }

                      });
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
