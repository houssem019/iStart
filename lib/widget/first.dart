import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FirstTime extends StatefulWidget {
  String text1;
  String text2;
  String text3;
  double height;
  FirstTime(this.text1, this.text2, this.height, this.text3);
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.height),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.text1,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 46, 64, 84),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 0)),
                overlayColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 190, 210, 224)),
              ),
              child: Text(
                widget.text2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(widget.text3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
