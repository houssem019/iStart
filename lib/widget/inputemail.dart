import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputEmail extends StatelessWidget {
  static TextEditingController inputemail = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: TextFormField(
            controller: inputemail,
            style: TextStyle(
              color: Color.fromARGB(255, 190, 210, 224),
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.alternate_email_rounded,
                color: Color.fromARGB(255, 190, 210, 224),
                size: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(27.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(27.0),
              ),
              filled: true,
              hintText: 'Enter your email',
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 190, 210, 224), fontSize: 10),
              border: InputBorder.none,
              fillColor: Color.fromARGB(255, 46, 64, 84).withOpacity(0.6),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 190, 210, 224),
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
