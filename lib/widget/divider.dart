import 'package:flutter/material.dart';
class Div extends StatelessWidget {
  const Div({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35,left: 50, right: 50),
      child: Column(
        children: [
          Text("Or",style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
          ),),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Color.fromARGB(255, 46, 64, 84),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}