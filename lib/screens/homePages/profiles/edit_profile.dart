import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
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
  DateTime selectedDate = DateTime.now();
  String levelValue = 'ເລີມຕົ້ນ';
  String statusValue = 'ໂສດ';
  bool pickedDay = false;
  bool loading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        pickedDay = true;
      });
  }

  //Detail
  Users _users = Users();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

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
              _users.gender = _gender;
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
            _users.gender = _gender;
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
        child: loading == false
            ? Container(
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Users')
                      .document(currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    nameController.text = snapshot.data['name'];
                    surnameController.text = snapshot.data['surname'];
                    captionController.text = snapshot.data['caption'];
                    weightController.text = snapshot.data['weight'];
                    heightController.text = snapshot.data['height'];
                    return Container(
                      margin: EdgeInsets.all(15),
                      child: ListView(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyBackButton(),
                                InkWell(
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                  onTap: () {
                                    print(_gender);
                                    print(selectedDate);
                                    print(levelValue);
                                    print(nameController.text);
                                    updateUserProfile();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              'ແກ້ໄຂຂໍ້ມູນສ່ວນໂຕ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(children: [
                            Expanded(
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(labelText: 'ຊື່'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: surnameController,
                                decoration:
                                    InputDecoration(labelText: 'ນາມສະກຸນ'),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: captionController,
                            decoration: InputDecoration(
                                labelText: 'ຄຳອະທິບາຍ',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                )),
                          ),
                          genderPicker,
                          InkWell(
                            child: Row(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(pickedDay == true
                                    ? '${selectedDate.toLocal()}'.split(' ')[0]
                                    : snapshot.data['birthDay'])
                              ],
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          Row(
                            children: [
                              Text(
                                'ສະຖານະ:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<String>(
                                value: statusValue,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.orange),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    statusValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'ໂສດ',
                                  'ມີຄວາມສຳພັນ',
                                ].map((String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'ນ້ຳໜັກ:',
                                style: TextStyle(fontSize: 18),
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: weightController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'ລວງສູງ:',
                                style: TextStyle(fontSize: 18),
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: heightController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'ລະດັບ:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<String>(
                                value: levelValue,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.orange),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    levelValue = newValue;
                                  });
                                },
                                items: <String>['ເລີມຕົ້ນ', 'ປານກາງ', 'ຊຳນານ']
                                    .map((String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : CircularProgress(
                title: 'ກຳລັງບັນທຶກ...',
              ),
      ),
    );
  }

  Future<void> updateUserProfile() async {
    loading = true;
    String birthDay = '${selectedDate.toLocal()}'.split(' ')[0];
    _users.name = nameController.text;
    _users.surname = surnameController.text;
    _users.caption = captionController.text;
    _users.weight = weightController.text;
    _users.height = heightController.text;
    _users.birthDay = birthDay;
    _users.updateProfile().then((value)async {
      setState(() {
      });
      await Future.delayed(const Duration(seconds: 2));
      loading = false;
      Navigator.of(context).pop();
    });
  }
}
