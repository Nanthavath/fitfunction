import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/models/type_ex.dart';
import 'package:fitfunction/models/workoutModel.dart';
import 'package:fitfunction/screens/createAccount/getBirthDayPage.dart';
import 'package:fitfunction/screens/homePages/workoutPage/setPlan_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

//List<bool> selectedActivity = [];
WorkoutModel workoutModel = WorkoutModel();

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

var _isSelected = false;

int _valueType = 0;
String type = '';

int _valueLevel = 0;
String level = '';

int _valueDay = 0;
final fromKey = GlobalKey<FormState>();

List<bool> selectedDay = [false, false, false, false, false, false, false];
List<String> days = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
List<String> dayFullname = [
  'ວັນຈັນ',
  'ວັນອັງຄານ',
  'ວັນພຸດ',
  'ວັນພະຫັດ',
  'ວັນສຸກ',
  'ວັນເສົາ',
  'ວັນທິດ',
];
int _selectedDayAmount = 0;

class _CreatePlanState extends State<CreatePlan> {
  @override
  void initState() {
    _valueType = 0;
    _valueLevel = 0;
    _valueDay = 0;
    selectedDay = [false, false, false, false, false, false, false];
//    workoutModel = WorkoutModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectDay = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(days.length, (index) {
        return ChoiceChip(
          label: Text(days[index].toString()),
          selected: selectedDay[index],
          labelStyle: TextStyle(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Color(0xffededed),
          onSelected: (isSelected) {
            setState(() {
              _selectedDayAmount = 0;
              for (var i in selectedDay) {
                if (i == true) {
                  _selectedDayAmount++;
                }
              }

              if (_selectedDayAmount < _valueDay) {
                selectedDay[index] = isSelected;
              } else {
                selectedDay[index] = false;
              }

              if (_valueDay == 7) {
                selectedDay = [true, true, true, true, true, true, true];
              }
            });
          },
          selectedColor: Colors.orange,
        );
      }),
    );
    final daysPerWeek = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          return GestureDetector(
            onTap: () => setState(() {
              _valueDay = index + 1;
              selectedDay = [false, false, false, false, false, false, false];
              if (_valueDay == 7) {
                selectedDay = [true, true, true, true, true, true, true];
              }
            }),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                color:
                    _valueDay == index + 1 ? Colors.orange : Colors.transparent,
              ),
              width: 30,
              child: Center(
                  child: Text(
                '${(index + 1).toString()}',
                style: TextStyle(fontSize: 25),
              )),
            ),
          );
        }));
    final levelEx = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _valueLevel = 1;
            level = 'ເລີ່ມຕົ້ນ';
          }),
          child: Container(
            width: 60,
            color: _valueLevel == 1 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/beginner.png'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _valueLevel = 2;
            level = 'ປານກາງ';
          }),
          child: Container(
            width: 80,
            color: _valueLevel == 2 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/intermediate.png'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _valueLevel = 3;
            level = 'ລະດັບສູງ';
          }),
          child: Container(
            width: 70,
            color: _valueLevel == 3 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/advance.png'),
              ],
            ),
          ),
        ),
      ],
    );
    final selectType = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _valueType = 1;
            type = 'ຫຼຸດນ້ຳໜັກ';
          }),
          child: Container(
            width: 56,
            color: _valueType == 1 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/cutting_icon.png'),
                Text('ຫຼຸດນ້ຳໜັກ'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _valueType = 2;
            type = 'ເພີ່ມນ້ຳໜັກ';
          }),
          child: Container(
            width: 60,
            color: _valueType == 2 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/bulking_icon.png'),
                Text('ເພີ່ມນ້ຳໜັກ'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _valueType = 3;
            type = 'ທົວໄປ';
          }),
          child: Container(
            width: 56,
            color: _valueType == 3 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/general_icon.png'),
                Text('ທົວໄປ'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _valueType = 4;
            type = 'ກິລາ';
          }),
          child: Container(
            width: 56,
            color: _valueType == 4 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/sport_icon.png'),
                Text('ກິລາ'),
              ],
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          MyBackButton(),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'ສ້າງແຜນໃໝ່',
                            style:
                                TextStyle(fontSize: 25, color: Colors.orange),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' ຊື່ແຜນ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Form(
                        key: fromKey,
                        child: Container(
                          //color: Colors.orange,
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(hintText: 'ຊື່ແຜນ'),
                            onChanged: (value) {
                           //   print(value);
                              return workoutModel.namePlan = value;
                            },
                            validator: (value) =>
                                value.isEmpty ? 'ກະລຸນາໃສ່ຊື່ແຜນ' : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ຄຳອະທິບາຍ',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value)=>workoutModel.description=value,
                        ),
                      ),

                      Text(
                        '  ປະເພດ',
                        style: TextStyle(fontSize: 20),
                      ),
                      selectType,
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '  ລະດັບ',
                        style: TextStyle(fontSize: 20),
                      ),
                      levelEx,
                      Text(
                        '  ມື້/ອາທິດ',
                        style: TextStyle(fontSize: 20),
                      ),
                      daysPerWeek,
                      selectDay,
                    ],
                  ),
                ),
//              Expanded(
//                child: ,
//              ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  //color: Colors.orange,
                  child: SubmitButton(
                    title: 'ຖັດໄປ',
                    onPressed: () {

                      final form = fromKey.currentState;
                      if (form.validate()) {
                        formKey.currentState.save();
                        if (_valueType < 1) {
                          warningDialog(context, 'ກະລຸນາເລືອກປະເພດ');
                          return;
                        }
                        workoutModel.type = type;
                        if (_valueLevel < 1) {
                          warningDialog(context, 'ກະລຸນາເລືອກລະດັບ');
                          return;
                        }
                        workoutModel.level = level;
                        int currentlySelectedDayAmount = 0;
                        List<String> selectedDayName = [];
                        for (int i = 0; i < days.length; i++) {
                          if (selectedDay[i] == true) {
                            currentlySelectedDayAmount++;
                            selectedDayName.add(dayFullname[i]);
                          }
                        }

                        if (currentlySelectedDayAmount == 0 ||
                            currentlySelectedDayAmount < _valueDay) {
                          warningDialog(context, 'ກະລຸນາເລືອກວັນໃຫ້ຄົບຖ້ວນ');
                          return;
                        }
                        workoutModel.dayPerWeek = _valueDay;
                        workoutModel.selectedDayName = selectedDayName;

//                        print("I'm here!");
//                        print(workoutModel.type);
//                        print(workoutModel.level);
//                        print(workoutModel.selectedDayName);
                        print(workoutModel.namePlan);
//                        summeryData = [];
                        keepAllExercises();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SetPlan()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> keepAllExercises() async {
    Firestore store = Firestore.instance;
    QuerySnapshot querySnapshot =
        await store.collection('Exercises').getDocuments();
    selectedActivity = List(querySnapshot.documents.length);
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      selectedActivity[i] = false;
    }
    print(selectedActivity);
  }
}
