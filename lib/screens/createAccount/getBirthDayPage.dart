import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';
import 'package:fitfunction/screens/createAccount/getEmailPage.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

// ignore: must_be_immutable

class GetBirthDayPage extends StatefulWidget {
  @override
  _GetBirthDayPageState createState() => _GetBirthDayPageState();
}

enum Genders { male, female }

class _GetBirthDayPageState extends State<GetBirthDayPage> {
  Genders _genders = Genders.male;
  DateTime selectedDate = DateTime.now();
  String _gender;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final males = ListTile(
      title: const Text('ຊາຍ'),
      leading: Radio(
        value: Genders.male,
        groupValue: _genders,
        onChanged: (Genders value) {
          setState(() {
            _genders = value;
            if (value == Genders.male) {
              _gender = 'ຊາຍ';
            }
            myUser.gender = _gender;
          });
        },
      ),
    );
    final females = ListTile(
      title: const Text('ຍິງ'),
      leading: Radio(
        value: Genders.female,
        groupValue: _genders,
        onChanged: (Genders value) {
          setState(() {
            _genders = value;
            if (value == Genders.female) {
              _gender = 'ຍິງ';
            }
            myUser.gender = _gender;
          });
        },
      ),
    );

    final surnameText = TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          hintText: 'ນາມສະກຸນ'),
    );

    final summitButton = Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
//            side: BorderSide()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ຖັດໄປ',
                style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
          onPressed: () {
            submit(context);
          },
        ),
      ),
    );
    final backButton = Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange),
        ),
        child: BackButton(),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                backButton,
                Text(
                  'ສ້າງບັນຊີຜູ້ໃຊ້ໃຫມ່',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'ວັນ, ເດືອນ, ປີເກີດ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate(context);
                              myUser.birthDay =
                                  '${selectedDate.toLocal()}'.split(' ')[0];
                            },
                          ),
                          Text('${selectedDate.toLocal()}'.split(' ')[0]),
                        ],
                      ),
                      Text(
                        'ເພດ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: males),
                          Expanded(child: females),
                        ],
                      ),
                    ],
                  ),
                ),
                summitButton
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => GetEmailPage()));
    print('${myUser.birthDay}\nGender:${myUser.gender}');
  }
}
