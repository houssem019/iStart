import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:istart/net/database.dart';
import 'package:istart/postimage.dart';
import 'package:istart/widget/pagetransition.dart';

import 'chat_details.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String name;
  String surname;
  String profile;
  String Cover;
  String bio;
  String uid;
  Profile(
      {required this.name,
      required this.surname,
      required this.profile,
      required this.Cover,
      required this.bio,
      required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map? following;
  bool? followed;

  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(milliseconds: 1500), () {
  //     setState(() {
  //       following = Following;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      DatabaseService().fetchFollowingList();
      Timer(Duration(milliseconds: 900), () {
        setState(() {
          following = Following;
          if (Following["${widget.uid}"] == null) {
            followed = false;
          } else {
            followed = Following["${widget.uid}"]["followed"];
          }
        });
      });
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
            "${widget.name} ${widget.surname}",
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
        body: ConditionalBuilder(
          condition: following != null,
          builder: (context) => ListView(
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
                                            postimage: "${widget.Cover}")));
                              },
                              child: Hero(
                                tag: "postimage",
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
                                      image: NetworkImage("${widget.Cover}"),
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
                                          postimage: "${widget.profile}")));
                            },
                            child: Hero(
                              tag: "postimage",
                              child: CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Color.fromARGB(255, 46, 64, 84),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage("${widget.profile}"),
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
                      "${widget.name} ${widget.surname}",
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
                        "${widget.bio}",
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
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
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
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
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
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Likes",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
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
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 210, 224)),
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
                                if (followed == true) {
                                  DatabaseService()
                                      .UnFollow(followedId: widget.uid);
                                } else {
                                  DatabaseService()
                                      .Follow(followedId: widget.uid);
                                }
                              },
                              child: followed == false
                                  ? Text(
                                      'Follow',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 46, 64, 84),
                                      ),
                                    )
                                  : Text(
                                      'Unfollow',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 46, 64, 84),
                                      ),
                                    ),
                              style: followed == false
                                  ? ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Color.fromARGB(255, 190, 210, 224),
                                      ),
                                      elevation: MaterialStateProperty.all(5.0),
                                    )
                                  : ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.grey,
                                      ),
                                      elevation: MaterialStateProperty.all(5.0),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chatdetails(
                                              widget.name,
                                              widget.surname,
                                              widget.profile,
                                              widget.Cover,
                                              widget.bio,
                                              widget.uid,
                                            )));
                              },
                              child: Text(
                                "Message",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 46, 64, 84),
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 190, 210, 224),
                                ),
                                elevation: MaterialStateProperty.all(5.0),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          fallback: (context) => LinearProgressIndicator(
            color: Color.fromARGB(255, 190, 210, 224),
          ),
        ),
      );
    });
  }
}
