import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/models/type_ex.dart';
import 'package:fitfunction/screens/homePages/workoutPage/setPlan_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

var _isSelected = false;

int _valueType = 0;
int _valueLevel = 0;

int _valueDay = 0;

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
int _selectedDayAmount = 0;

class _CreatePlanState extends State<CreatePlan> {
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
          onTap: () => setState(() => _valueLevel = 1),
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
          onTap: () => setState(() => _valueLevel = 2),
          child: Container(
            width: 80,
            color: _valueLevel == 2 ? Colors.grey : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/intermediate.png'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _valueLevel = 3),
          child: Container(
            width: 70,
            color: _valueLevel == 3 ? Colors.grey : Colors.transparent,
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
          onTap: () => setState(() => _valueType = 1),
          child: Container(
            width: 56,
            color: _valueType == 1 ? Colors.orange : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/cutting_icon.png'),
                Text('cutting'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _valueType = 2),
          child: Container(
            width: 56,
            color: _valueType == 2 ? Colors.grey : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/bulking_icon.png'),
                Text('bulking'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _valueType = 3),
          child: Container(
            width: 56,
            color: _valueType == 3 ? Colors.grey : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/general_icon.png'),
                Text('general'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _valueType = 4),
          child: Container(
            width: 56,
            color: _valueType == 4 ? Colors.grey : Colors.transparent,
            child: Column(
              children: [
                Image.asset('images/sport_icon.png'),
                Text('sport'),
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
                          style: TextStyle(fontSize: 25, color: Colors.orange),
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
                    Container(
                      //color: Colors.orange,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'ຊື່ແຜນ'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SetPlan()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
