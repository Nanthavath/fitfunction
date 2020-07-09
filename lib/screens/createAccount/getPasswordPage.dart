import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';

final formKey = GlobalKey<FormState>();

Authentication authentication = Authentication();

// ignore: must_be_immutable
class GetPasswordPage extends StatelessWidget {
  String _pass;

  @override
  Widget build(BuildContext context) {
    final passwordText = TextFormField(
      obscureText: true,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: 'ຢືນຢັນລະຫັດຜ່ານ',
        hintStyle: TextStyle(fontSize: 20),
      ),
      validator: (value) {
        return value != _pass ? 'ໃສ່ລະຫັດຜ່ານໃຫ້ຕົງກັນ' : null;
      },
      onChanged: (value) => users.password = value,
    );
    final passText = TextFormField(
      obscureText: true,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: 'ລະຫັດຜ່ານ',
        hintStyle: TextStyle(fontSize: 20),
      ),
      validator: Validator.passwordValidate,
      onSaved: (value) => _pass = value,
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
                'ສຳເລັດ',
                style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
          onPressed: () async {
            validator();
//            if (validator() == true) {
//              authentication.createAccountWithEmail().then((value){
//                print(value.uid);
//                Navigator.of(context).pushAndRemoveUntil(
//                    MaterialPageRoute(
//                        builder: (BuildContext context) => HomePage()),
//                        (Route<dynamic> route) => false);
//              });
//            }
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
                      passText,
                      passwordText,
                      SizedBox(
                        height: 15,
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

  bool validator() {
    formKey.currentState.save();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('${users.password}');

      return true;
    } else {
      return false;
    }
  }
}
