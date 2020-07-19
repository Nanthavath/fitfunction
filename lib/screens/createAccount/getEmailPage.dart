import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';
import 'package:fitfunction/screens/createAccount/getPasswordPage.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class GetEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailText = TextFormField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: 'ອີເມລ',
        hintStyle: TextStyle(fontSize: 20),
      ),
      validator: Validator.emailValidate,
      onSaved: (value) => myUser.email = value,
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
                      emailText,
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

  bool submit(BuildContext context) {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      print('${myUser.email}');

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => GetPasswordPage(),
        ),
      );
      return true;
    } else {
      return false;
    }
  }
}
