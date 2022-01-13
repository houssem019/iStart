import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  String text1;
  String text2;
  TextEditingController inputpassword = TextEditingController();
  PasswordInput(this.text1, this.text2);
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

TextEditingController inputpassword = TextEditingController();

class _PasswordInputState extends State<PasswordInput> {
  
  bool passwordvisable = true;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: inputpassword,
          obscureText: passwordvisable,
          style: TextStyle(
            color: Color.fromARGB(255, 190, 210, 224),
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  passwordvisable ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: Color.fromARGB(255, 190, 210, 224),
                ),
                onPressed: () {
                  setState(() {
                    passwordvisable = !passwordvisable;
                  });
                }),
            focusedBorder:OutlineInputBorder(
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
            hintText: widget.text1,
            hintStyle:
                TextStyle(color: Color.fromARGB(255, 190, 210, 224), fontSize: 10),
            border: InputBorder.none,
            fillColor: Color.fromARGB(255, 46, 64, 84).withOpacity(0.6),
            labelText: widget.text2,
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
