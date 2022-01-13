import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerticalText extends StatefulWidget {
  String text1;
  String text2;
  VerticalText(this.text1,this.text2);
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, left: 35,bottom: 30),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text1,
            style: TextStyle(
              color: Color.fromARGB(255, 46, 64, 84),
              fontSize: 45,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left:20),
            child: Text(
              widget.text2,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 46, 64, 84),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
