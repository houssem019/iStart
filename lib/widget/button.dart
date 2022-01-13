import 'dart:async';

import 'package:flutter/material.dart';
import 'package:istart/net/flutterfire.dart';
import 'package:istart/widget/forgot.dart';
import 'package:istart/widget/password.dart';
import 'inputemail.dart';

// ignore: must_be_immutable
class ButtonLogin extends StatefulWidget {
  String text;
  ButtonLogin(this.text);

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  var loading = false;

  var email = InputEmail.inputemail;

  var password = inputpassword;

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Padding(
            padding: const EdgeInsets.only(top: 20, right: 90, left: 90),
            child: Container(
              alignment: Alignment.bottomRight,
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 46, 64, 84),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: widget.text == 'Sign Up'
                  ? TextButton(
                      onPressed: () async {
                        bool shouldNavigate =
                            await signup(email.text, password.text);
                        if (shouldNavigate) {
                          setState(() {
                            loading = true;
                          });
                          Timer(Duration(milliseconds: 2000), () {
                            Navigator.of(context).pushReplacementNamed('/e');
                            InputEmail.inputemail = TextEditingController();
                            inputpassword = TextEditingController();
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: Color.fromARGB(255, 190, 210, 224),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  : TextButton(
                      onPressed: () async {
                        bool shouldNavigate =
                            await signin(email.text, password.text);
                        InputEmail.inputemail = TextEditingController();
                        inputpassword = TextEditingController();
                        if (shouldNavigate) {
                          setState(() {
                            loading = true;
                          });
                          Timer(Duration(milliseconds: 2000), () {
                            Navigator.of(context).pushReplacementNamed('/e');
                            InputEmail.inputemail = TextEditingController();
                            inputpassword = TextEditingController();
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: Color.fromARGB(255, 190, 210, 224),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 33, right: 90, left: 90),
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 46, 64, 84),
            ),
          );
  }

}
