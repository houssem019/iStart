import 'package:flutter/material.dart';
import 'package:istart/widget/button.dart';
import 'package:istart/widget/divider.dart';
import 'package:istart/widget/first.dart';
import 'package:istart/widget/forgot.dart';
import 'package:istart/widget/inputemail.dart';
import 'package:istart/widget/password.dart';
import 'package:istart/widget/social.dart';
import 'package:istart/widget/verticaltext.dart';


class Signin extends StatefulWidget {
  @override
  _Signin createState() => _Signin();
}

class _Signin extends State<Signin> {
  
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
                    VerticalText('Sign In', 'A world of possibility in an app'),
                  ]),
                  InputEmail(),
                  PasswordInput("Enter your password", 'Password'),
                  Forgot(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ButtonLogin('Sign In'),
                  ),
                  Div(),
                  Social(),
                  FirstTime(
                      'Don\'t have an account ?', ' Create new one', 180, '/d'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
