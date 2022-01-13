import 'package:flutter/material.dart';

class checkbox extends StatefulWidget {
  const checkbox({Key? key}) : super(key: key);

  @override
  _checkboxState createState() => _checkboxState();
}

class _checkboxState extends State<checkbox> {
  bool? keepmeloggedin = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 52),
      child: Checkbox(
        value: keepmeloggedin,
        onChanged: (bool? val) {
          setState(() {
            keepmeloggedin = val;
          });
        },
        activeColor: Color.fromARGB(255, 46, 64, 84),
        overlayColor: MaterialStateProperty.all(null),
        focusColor: Color.fromARGB(255, 46, 64, 84),
        checkColor: Color.fromARGB(255, 190, 210, 224),
      ),
    );
  }
}
