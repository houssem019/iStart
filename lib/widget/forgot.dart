import 'package:flutter/material.dart';
import 'package:istart/reset.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

bool Keeplogged = false;

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 52),
      child: Container(
        alignment: Alignment.topRight,
        height: 20,
        child: Container(
          child: Row(
            children: [
              Checkbox(
                value: Keeplogged,
                onChanged: (bool? val) {
                  setState(() {
                    Keeplogged = val!;
                  });
                },
                activeColor: Color.fromARGB(255, 46, 64, 84),
                overlayColor: MaterialStateProperty.all(null),
                focusColor: Color.fromARGB(255, 46, 64, 84),
                checkColor: Color.fromARGB(255, 190, 210, 224),
              ),
              Text(
                'Remember me',
                style: TextStyle(
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 85,
              ),
              InkWell(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Resetpassword()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
