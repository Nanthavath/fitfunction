import 'package:fitfunction/screens/createAccount/getBirthDayPage.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class GetNamePage extends StatelessWidget {
  String _name;
  String _surname;

  @override
  Widget build(BuildContext context) {
    final surnameText = TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          hintText: 'ນາມສະກຸນ'),
      validator: Validator.surnameValidate,
      onSaved: (value) => _surname = value,
    );
    final nameText = TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          hintText: 'ຊື່'),
      validator: Validator.nameValidate,
      onSaved: (value) => _name = value,
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
            validate(context);
          },
        ),
      ),
    );
    final backButton = Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.orange)),
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: nameText,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: surnameText,
                          ),
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

  bool validate(BuildContext context) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GetBirthDayPage()));
      return true;
    } else {
      return false;
    }
  }
}
