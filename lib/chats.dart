import 'dart:async';

import 'package:flutter/material.dart';
import 'package:istart/chat_details.dart';
import 'package:istart/net/database.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  var lastmessage = [];

  var allusers = AllUsers;
  Widget buildChatitem(BuildContext context, int index) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage("${allusers[index]["image"]}"),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${allusers[index]["Name"]} ${allusers[index]["surname"]}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 190, 210, 224),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                //if(lastmessage.last["receiverId"]==allusers[index]["uid"])
                Text(
                  "Last message",
                  style: TextStyle(
                    color: Color.fromARGB(255, 190, 210, 224),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatdetails(
              "${allusers[index]["Name"]}",
              "${allusers[index]["surname"]}",
              "${allusers[index]["image"]}",
              "${allusers[index]["cover"]}",
              "${allusers[index]["bio"]}",
              "${allusers[index]["uid"]}",
            ),
          ),
        );
      },
    );
  }

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
          "Chats",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return buildChatitem(context, index);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            endIndent: 10,
            indent: 10,
            height: 1,
            thickness: 1,
            color: Color.fromARGB(255, 190, 210, 224),
          ),
        ),
        itemCount: allusers.length,
      ),
    );
  }
}
