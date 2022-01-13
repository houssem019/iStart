import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 40, right: 52),
      child: Container(
        alignment: Alignment.topRight,
        // height: 100,
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (bool? val) {
                      setState(() {
                        value = val;
                      });
                    },
                    activeColor: Color.fromARGB(255, 46, 64, 84),
                    overlayColor: MaterialStateProperty.all(null),
                    focusColor: Color.fromARGB(255, 46, 64, 84),
                    checkColor: Color.fromARGB(255, 190, 210, 224),
                  ),
                  Text(
                    'By signing up you accept the term of service',
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                    ),
                    textAlign: TextAlign.right,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:48),
                    child: Text(
                      'and privacy policy',
                      style: TextStyle(
                        color: Color.fromARGB(255, 46, 64, 84),
                      ),
                      textAlign: TextAlign.right,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
