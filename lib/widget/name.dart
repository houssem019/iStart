import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Name extends StatelessWidget {
  static TextEditingController name = TextEditingController();
  String text1;
  String text2;
  Name(this.text1, this.text2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: name,
          style: TextStyle(
            color: Color.fromARGB(255, 190, 210, 224),
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(27.0),
            ),
            suffixIcon: Icon(
              Icons.person_rounded,
              color: Color.fromARGB(255, 190, 210, 224),
              size: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(27.0),
            ),
            filled: true,
            hintText: text1,
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 190, 210, 224), fontSize: 10),
            border: InputBorder.none,
            fillColor: Color.fromARGB(255, 46, 64, 84).withOpacity(0.6),
            labelText: text2,
            labelStyle: TextStyle(
              color: Color.fromARGB(255, 190, 210, 224),
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
