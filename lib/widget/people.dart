

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:istart/net/database.dart';

import '../profile.dart';

// ignore: must_be_immutable
class People extends StatefulWidget {
  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  var allusers = AllUsers;
  var following = Following;
  int? friendindex;

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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 190, 210, 224))),
                    onPressed: () {},
                    child: Text(
                      "Requests",
                      style: TextStyle(
                        color: Color.fromARGB(255, 46, 64, 84),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 190, 210, 224))),
                  onPressed: () {},
                  child: Text(
                    "Followers",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              endIndent: 10,
              indent: 10,
              color: Color.fromARGB(255, 190, 210, 224),
              height: 1,
              thickness: 1,
            ),
          ),
          ConditionalBuilder(
            condition: allusers.length > 0,
            builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // for (int i = 0; i < following.length; i++) {
                  //   print(i);
                  //   if (allusers[index]["uid"] ==
                  //           following["${allusers[i]["uid"]}"]["followedId"] &&
                  //       following["${allusers[i]["uid"]}"]["followed"] ==
                  //           true) {
                  //     return Container();
                  //   }
                  // }

                  return buildfriendItem(context, index);
                },
                itemCount: allusers.length,
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    )),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildfriendItem(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage("${allusers[index]["image"]}"),
                ),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  child: Text(
                    "${allusers[index]["Name"]} ${allusers[index]["surname"]}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  name: "${allusers[index]["Name"]}",
                                  surname: "${allusers[index]["surname"]}",
                                  profile: "${allusers[index]["image"]}",
                                  Cover: "${allusers[index]["cover"]}",
                                  bio: "${allusers[index]["bio"]}",
                                  uid: "${allusers[index]["uid"]}",
                                )));
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150.0),
                    child: ElevatedButton(
                      style: friendindex != index
                          ? ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 46, 64, 84),
                              ))
                          : ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                      onPressed: () {
                        setState(() {
                          friendindex = index;
                        });
                        DatabaseService()
                            .Follow(followedId: allusers[index]["uid"]);
                      },
                      child: friendindex == index
                          ? Text(
                              "Unfollow",
                              style: TextStyle(
                                color: Color.fromARGB(255, 46, 64, 84),
                              ),
                            )
                          : Text(
                              "Follow",
                              style: TextStyle(
                                color: Color.fromARGB(255, 190, 210, 224),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 46, 64, 84),
                      )),
                  onPressed: () {},
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Color.fromARGB(255, 190, 210, 224),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
