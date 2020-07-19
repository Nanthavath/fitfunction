import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/models/users.dart';
import 'package:fitfunction/screens/createAccount/getEmailPage.dart';
import 'package:fitfunction/screens/createAccount/getNamePage.dart';
import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:fitfunction/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfunction/models/adapter.dart';
final formKey = GlobalKey<FormState>();
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Authen authentication = Authen();
  String email;
  String pass;

  @override
  void initState() {
    super.initState();
    switchPage();
  }

  @override
  Widget build(BuildContext context) {
    final createAccount = FlatButton(
      child: Text(
        'ສ້າງບັນຊີຜູ້ໃຊ້ໃຫມ່',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => GetNamePage()));
      },
    );
    final facebookLoginButton = IconButton(
      icon: Image.asset('images/facebook_icon.png'),
      onPressed: () {},
    );
    final googleLoginButton = IconButton(
      icon: Image.asset('images/google_icon.png'),
      onPressed: () {},
    );
    final loginButton = RaisedButton(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        'ເຂົ້າສູ່ລະບົບ',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        validate();
        if (validate() == true) {
          submit();
        }
      },
    );

    final passwordText = TextFormField(
      style: TextStyle(fontSize: 20),
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 20),
        hintText: 'ລະຫັດຜ່ານ',
      ),
      validator: Validator.passwordValidate,
      onSaved: (value) => pass = value,
    );
    final emailText = TextFormField(
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 20),
        hintText: 'ອີເມລ',
      ),
      validator: Validator.emailValidate,
      onSaved: (value) => email = value,
    );
    final logoArea = Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Center(
        child: Container(
          height: 145,
          width: 145,
          child: Image.asset('images/app_logo.png'),
        ),
      ),
    );

    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          child: ListView(
            children: <Widget>[
              logoArea,
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    emailText,
                    passwordText,
                    SizedBox(
                      height: 20,
                    ),
                    loginButton,
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        googleLoginButton,
                        facebookLoginButton,
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    createAccount,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() {
    authentication.signInWithEmail(email, pass).then((value) {
     currentUser=value;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);

    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Future<String> switchPage() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    if (user.uid != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
    return user.uid;
  }
}
