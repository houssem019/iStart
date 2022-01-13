import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:istart/widget/verticaltext.dart';

import 'widget/inputemail.dart';

// ignore: must_be_immutable
class Resetpassword extends StatelessWidget {
  var email = InputEmail.inputemail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Expanded(
          child: Container(
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
                        VerticalText('Reset Password',
                            'Your dream is waiting for you !'),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      InputEmail(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Container(
                                alignment: Alignment.topRight,
                                height: 50,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 46, 64, 84),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: email.text)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg: 'check your e-mail',
                                          backgroundColor:
                                              Color.fromARGB(255, 46, 64, 84),
                                          timeInSecForIosWeb: 4);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Send request",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 210, 224),
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 60),
          child: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 26,
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
                Text(
                  "Go Back",
                  style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    ));
  }
}
