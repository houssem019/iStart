import 'package:flutter/material.dart';
import 'package:istart/widget/button.dart';
import 'package:istart/widget/first.dart';
import 'package:istart/widget/inputemail.dart';
import 'package:istart/widget/name.dart';
import 'package:istart/widget/password.dart';
import 'package:istart/widget/suname.dart';
import 'package:istart/widget/terms.dart';
import 'package:istart/widget/verticaltext.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 55, 134, 150),
              Color.fromARGB(255, 190, 210, 224),
            ],
          ),
        ),
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    VerticalText('Sign Up', 'Welcome among us !'),
                  ]),
                  Name("Enter your name", "Name"),
                  Surname("Enter your surname", "Surname"),
                  InputEmail(),
                  PasswordInput("Enter your password", 'Password'),
                  PasswordInput("Re-enter your password", 'Confirm password'),
                  Terms(),
                  ButtonLogin('Sign Up'),
                  FirstTime('Already have an account ?', ' Sign In', 50, '/a')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
