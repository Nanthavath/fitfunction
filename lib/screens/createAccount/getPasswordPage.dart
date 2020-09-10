import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/models/adapter.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:fitfunction/validator.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';

final formKey = GlobalKey<FormState>();

Authen authentication = Authen();

// ignore: must_be_immutable
class GetPasswordPage extends StatefulWidget {
  @override
  _GetPasswordPageState createState() => _GetPasswordPageState();
}

class _GetPasswordPageState extends State<GetPasswordPage> {
  String _pass;
  bool loading = false;

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
      onChanged: (value) => myUser.password = value,
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
            if (validator() == true) {
              submit(context);
            } else {
              print('Register Fail');
            }
//            if (validator() == true) {
//              authentication.createAccountWithEmail().then((value){
//                print(value.uid);
//
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
      body: loading == false
          ? SafeArea(
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
            )
          : CircularProgress(
              title: 'ກຳລັງລົງທະບຽນ...',
            ),
    );
  }

  bool validator() {
    formKey.currentState.save();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('${myUser.password}');
      return true;
    } else {
      return false;
    }
  }

  void submit(BuildContext context) {

    myUser.createUserWithEmail().then((value) {
      setState(() {
        loading=true;
        print(value.uid);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                (Route<dynamic> route) => false);
        loading=false;
      });
    });
  }
}
