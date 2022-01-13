import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:istart/chats.dart';
import 'package:istart/myprofile.dart';
import 'package:istart/net/flutterfire.dart';
import 'package:istart/settings.dart';

import 'mymoney.dart';

class Drawers extends StatelessWidget {
  Widget buildListtile(String title, IconData icon, Function()? tapHandler) {
    return ListTile(
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Color.fromARGB(255, 190, 210, 224),
      ),
      leading: Icon(
        icon,
        size: 26,
        color: Color.fromARGB(255, 46, 64, 84),
      ),
      title: Text(title,
          style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
      onTap: tapHandler,
    );
  }

  Widget div() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Divider(
        indent: 10,
        endIndent: 10,
        color: Color.fromARGB(255, 46, 64, 84),
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 190, 210, 224),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "iStart",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
              ),
            ),
          ),
          div(),
          buildListtile("My profile", Icons.person_pin, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Myprofile()));
          }),
          div(),
          buildListtile("My pocket money", Icons.money, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mymoney()));
          }),
          div(),
          buildListtile("Chats", Icons.chat, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chats()));
          }),
          div(),
          buildListtile("Settings & Privacy", Icons.settings, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          }),
          div(),
          Spacer(),
          // SizedBox(
          //   height: 250,
          // ),
          Padding(
            padding: EdgeInsets.only(right: 50, left: 50, bottom: 50),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 46, 64, 84),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextButton(
                onPressed: () async {
                  bool leave = await logout();
                  await googlesignout();
                  await facebooksingout();
                  if (leave) {
                    Navigator.of(context).pushReplacementNamed('/a');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: Color.fromARGB(255, 190, 210, 224),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
