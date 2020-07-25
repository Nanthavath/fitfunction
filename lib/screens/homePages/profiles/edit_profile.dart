import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

enum Genders {
  male,
  female,
}

class _EditProfileState extends State<EditProfile> {
  Genders _genders = Genders.male;
  String _gender;

  @override
  Widget build(BuildContext context) {
    final males = ListTile(
      title: const Text('ຊາຍ'),
      leading: Radio(
        value: Genders.male,
        groupValue: _genders,
        onChanged: (Genders value) {
          setState(
            () {
              _genders = value;
              if (value == Genders.male) {
                _gender = 'ຊາຍ';
              }
              myUser.gender = _gender;
            },
          );
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

    final genderPicker = Row(
      children: <Widget>[
        Text(' ເພດ:'),
        Expanded(
          child: males,
        ),
        Expanded(
          child: females,
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: MyBackButton(),
              ),
              Center(
                child: Text(
                  'ແກ້ໄຂໂປຣຟາຍ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ຊື່'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ນາມສະກຸນ'),
              ),
              genderPicker,
              TextFormField(
                decoration: InputDecoration(labelText: 'ຄຳອະທິບາຍ'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Level:'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
