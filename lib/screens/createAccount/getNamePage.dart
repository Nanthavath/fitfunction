import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getBirthDayPage.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();
//Users users=Users();
// ignore: must_be_immutable
class GetNamePage extends StatelessWidget {
//Users users=Users();

  @override
  Widget build(BuildContext context) {
    myUser=Users();
    final surnameText = TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          hintText: 'ນາມສະກຸນ'),
      validator: Validator.surnameValidate,
      onSaved: (value)=>myUser.surname=value,
    );
    final nameText = TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          hintText: 'ຊື່'),
      validator: Validator.nameValidate,
      onSaved: (value) => myUser.name=value,
    );
    final summitButton = Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 100,
        child: FloatingActionButton(
          elevation: 0,
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
        child: BackButton(
          color: Colors.orange,
        ),
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
