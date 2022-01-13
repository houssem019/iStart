import 'package:flutter/material.dart';

class Mymoney extends StatefulWidget {
  const Mymoney({Key? key}) : super(key: key);

  @override
  _MymoneyState createState() => _MymoneyState();
}

class _MymoneyState extends State<Mymoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 64, 84).withOpacity(1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 55, 134, 150),
                Color.fromARGB(255, 190, 210, 224),
              ],
            ),
          ),
        ),
        title: Text(
          "My pocket money",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/e');
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 10),
            child: Text(
              "You have in your account :",
              style: TextStyle(
                  color: Color.fromARGB(255, 190, 210, 224),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            height: 2,
            thickness: 1,
            endIndent: 150,
            indent: 30,
            color: Color.fromARGB(255, 190, 210, 224),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Image(
              image: ExactAssetImage("assets/images/money.png"),
              width: 200,
              height: 200,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 100,right: 140),
          //   child: TextField(
          //     textAlign: TextAlign.center,
          //     decoration: InputDecoration(
          //     ),
          //   ),
          // )
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:100),
                child: Container(
                  child: Text(
                    "5146200",
                    style: TextStyle(
                      color: Color.fromARGB(255, 190, 210, 224),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 190, 210, 224),
                  ),
                  child: Text(
                    "DT",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
