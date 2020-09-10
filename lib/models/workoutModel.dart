import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/screens/homePages/workoutPage/setPlan_page.dart';
import 'package:flutter/cupertino.dart';

class WorkoutModel {
  String _namePlan;
  String _type;
  String _description;

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get namePlan => _namePlan;

  set namePlan(String value) {
    _namePlan = value;
  }

  String _level;
  int _dayPerWeek;
  List<String> _selectedDayName;

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get level => _level;

  set level(String value) {
    _level = value;
  }

  int get dayPerWeek => _dayPerWeek;

  set dayPerWeek(int value) {
    _dayPerWeek = value;
  }

  List<String> get selectedDayName => _selectedDayName;

  set selectedDayName(List<String> value) {
    _selectedDayName = value;
  }

  Future<void> upLoadToDatabase() async {
    //  List data=[];
    Map<Object, Object> days_map = Map();
    Map<Object, Object> ex_map = Map();
    List favorite=[];

    //  for(int i=0;i<summeryData.length;i++){
    //    ex_map=Map();
    //    ex_map["Exercises"]=summeryData[i].selectedExercises.toList();
    //   // days_map=Map();
    //    days_map[summeryData[i].days]=ex_map;
    // //   data.add(days_map);
    //  }

    final docRef = await Firestore.instance.collection('Workout').add(
      {
        'workoutName': namePlan,
        'type': type,
        'level': level,
        'dayPerWeek': dayPerWeek,
        //'days': days_map,
        'description': description,
        'userID': currentUser.uid,
        'favorite':favorite.toList()
      },
    );
    // for(var dn in selectedDayName){
    // final days = await Firestore.instance
    //     .collection('Workout')
    //     .document(docRef.documentID)
    //     .collection('days').document(dn)
    //     .setData(
    //   {
    //     'exercise':
    //   },
    // );
    // }
     for(int i=0;i<summeryData.length;i++){
       final days = await Firestore.instance
           .collection('Workout')
           .document(docRef.documentID)
           .collection('days').document(summeryData[i].days)
           .setData(
         {
          'exercise':summeryData[i].selectedExercises.toList(),
         },
       );
     }

//   print(docRef.documentID);
  }
}
