import 'package:flutter/material.dart';
import 'package:istart/editprofile.dart';
import 'package:istart/net/database.dart';
import 'package:istart/postimage.dart';
import 'package:istart/widget/pagetransition.dart';

import 'newpost.dart';

// ignore: must_be_immutable
class Myprofile extends StatefulWidget {
  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  var usersinfo = userprofilecords;

  var uid = DatabaseService().id();

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
          "My profile",
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                AnimatedPageRoute(
                                    widget: PostImage(
                                        postimage:
                                            "${usersinfo[uid]["cover"]}")));
                          },
                          child: Hero(
                            tag: 'postimage',
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 190, 210, 224),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${usersinfo[uid]["cover"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              AnimatedPageRoute(
                                  widget: PostImage(
                                      postimage:
                                          "${usersinfo[uid]["image"]}")));
                        },
                        child: Hero(
                          tag: "postimage",
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Color.fromARGB(255, 46, 64, 84),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage("${usersinfo[uid]["image"]}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${usersinfo[uid]["Name"]} ${usersinfo[uid]["surname"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 190, 210, 224),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 10, left: 10, right: 10),
                  child: Text(
                    "${usersinfo[uid]["bio"]}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 190, 210, 224),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "516",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Color.fromARGB(255, 190, 210, 224),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "112",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Color.fromARGB(255, 190, 210, 224),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "1689",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Likes",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Color.fromARGB(255, 190, 210, 224),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "188",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 190, 210, 224)),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPost()));
                          },
                          child: Text(
                            'Add Post',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 46, 64, 84),
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 190, 210, 224),
                            ),
                            elevation: MaterialStateProperty.all(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Color.fromARGB(255, 46, 64, 84),
                            ),
                            Text(
                              " Edit profile",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 46, 64, 84),
                              ),
                            )
                          ],
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 190, 210, 224),
                          ),
                          elevation: MaterialStateProperty.all(5.0),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
