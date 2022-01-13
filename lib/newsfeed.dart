import 'dart:async';
import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:istart/customviewemojis.dart';
import 'package:istart/myprofile.dart';
import 'package:istart/net/database.dart';
import 'package:istart/postimage.dart';
import 'package:istart/profile.dart';
import 'package:istart/widget/pagetransition.dart';

// ignore: must_be_immutable
class NewsFeed extends StatefulWidget {
  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List posts=[];
  var users;
  List postsId=[];
  List likes=[] ;
  List comments=[];
  var loading = true;
  var liked = false;
  var verified = FirebaseAuth.instance.currentUser!.emailVerified;
  FocusNode focus = FocusNode();
  var comment = TextEditingController();
  ScrollController _scrolllcontroller = ScrollController();
  bool emojiShowing = false;
  final TextEditingController _controller = TextEditingController();
  _onEmojiSelected(Emoji emoji) {
    comment
      ..text += emoji.emoji
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: comment.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (focus.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        posts = Posts;
        users = userprofilecords;
        postsId = PostsId;
        likes = Likes;
        loading = false;
      });
    });
    
  }

  DisplayComments(BuildContext context, var postid) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Builder(builder: (context) {
            DatabaseService().getComments(postId: postid);
             Timer(Duration(milliseconds: 50), () {
          setState(() {
            comments = Comments;
          });
        });
            return BottomSheet(
              backgroundColor: Color.fromRGBO(255, 230, 250, 1),
              onClosing: () {},
              builder: (context) {
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(27),
                        topEnd: Radius.circular(27),
                      ),
                      color: Color.fromRGBO(255, 230, 250, 1),
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            showTrackOnHover: true,
                            radius: Radius.circular(20),
                            thickness: 3,
                            hoverThickness: 8,
                            child: ConditionalBuilder(
                              condition: comments.length > 0,
                              builder: (context) => ListView.separated(
                                controller: _scrolllcontroller,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 5,
                                        color:
                                            Color.fromARGB(255, 190, 210, 224),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                              right: 15,
                                              left: 5),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundImage: NetworkImage(
                                                    "${users["${comments[index]["commentor"]}"]["image"]}"),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    child: Text(
                                                      "${users["${comments[index]["commentor"]}"]["Name"]} ${users["${comments[index]["commentor"]}"]["surname"]}",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 46, 64, 84),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    onTap: () {
                              if (users["${comments[index]["commentor"]}"]["uid"] ==
                                  uid) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Myprofile()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                              name:
                                                  "${users["${comments[index]["commentor"]}"]["Name"]}",
                                              surname:
                                                  "${users["${comments[index]["commentor"]}"]["surname"]}",
                                              profile:
                                                  "${users["${comments[index]["commentor"]}"]["image"]}",
                                              Cover:
                                                  "${users["${comments[index]["commentor"]}"]["cover"]}",
                                              bio:
                                                  "${users["${comments[index]["commentor"]}"]["bio"]}",
                                              uid:
                                                  "${users["${comments[index]["commentor"]}"]["uid"]}",
                                            )));
                              }
                            },
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${comments[index]["comment"]}",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 46, 64, 84),
                                                    ),
                                                    maxLines: 5,
                                                    overflow: TextOverflow.fade,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${comments[index]["datetime"].substring(11, 16)}",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 46, 64, 84),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              InkWell(
                                                  child: Text(
                                                    "Like",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 46, 64, 84),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onTap: () {}),
                                              SizedBox(width: 20),
                                              InkWell(
                                                  child: Text(
                                                    "Reply",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 46, 64, 84),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onTap: () {})
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    Container(),
                              ),
                              fallback: (context) => SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.comment_outlined,
                                        size: 100,
                                        color: Color.fromARGB(255, 46, 64, 84),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "No comments yet",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 46, 64, 84),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        WillPopScope(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                // color: Color.fromARGB(255, 46, 64, 84),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, bottom: 3, right: 5, left: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(27),
                                          ),
                                          color: Color.fromARGB(
                                              255, 190, 210, 224),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: TextFormField(
                                              autofocus:true,
                                              focusNode: focus,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 46, 64, 84),
                                                fontSize: 18,
                                              ),
                                              controller: comment,
                                              cursorColor: Color.fromARGB(
                                                  255, 46, 64, 84),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                //filled: true,
                                                //fillColor: Color.fromARGB(255, 190, 210, 224),
                                                hintText:
                                                    'Type your Comment...',
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 46, 64, 84),
                                                    fontSize: 18),
                                                prefixIcon: IconButton(
                                                  color: Color.fromARGB(
                                                      255, 46, 64, 84),
                                                  focusColor: Color.fromARGB(
                                                      255, 46, 64, 84),
                                                  splashRadius: 28,
                                                  iconSize: 28,
                                                  icon: emojiShowing
                                                      ? Icon(Icons.keyboard)
                                                      : Icon(Icons
                                                          .emoji_emotions_outlined),
                                                  onPressed: () {
                                                    if (emojiShowing) {
                                                      focus.requestFocus();
                                                    } else {
                                                      focus.unfocus();
                                                      focus.canRequestFocus =
                                                          false;
                                                      setState(() {
                                                        emojiShowing =
                                                            !emojiShowing;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(
                                              255, 190, 210, 224),
                                        ),
                                        height: 50,
                                        child: MaterialButton(
                                          onPressed: () {
                                            DatabaseService().Comment(
                                              postid,
                                              comment.text,
                                              DateTime.now().toString(),
                                            );
                                            setState(() {
                                              comment = TextEditingController();
                                            });
                                          },
                                          minWidth: 1.0,
                                          child: Icon(
                                            Icons.send,
                                            size: 25,
                                            color:
                                                Color.fromARGB(255, 46, 64, 84),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              emoji(),
                            ],
                          ),
                          onWillPop: () {
                            if (emojiShowing) {
                              setState(() {
                                emojiShowing = false;
                              });
                            } else {
                              Navigator.pop(context);
                            }
                            return Future.value(false);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
            );
          });
        });
  }

  var uid = DatabaseService().id();
  Widget buildPostItem(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      "${users["${posts[index]["uid"]}"]["image"]}"),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: Text(
                              "${users["${posts[index]["uid"]}"]["Name"]} ${users["${posts[index]["uid"]}"]["surname"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 46, 64, 84),
                              ),
                            ),
                            onTap: () {
                              if (users["${posts[index]["uid"]}"]["uid"] ==
                                  uid) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Myprofile()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                              name:
                                                  "${users["${posts[index]["uid"]}"]["Name"]}",
                                              surname:
                                                  "${users["${posts[index]["uid"]}"]["surname"]}",
                                              profile:
                                                  "${users["${posts[index]["uid"]}"]["image"]}",
                                              Cover:
                                                  "${users["${posts[index]["uid"]}"]["cover"]}",
                                              bio:
                                                  "${users["${posts[index]["uid"]}"]["bio"]}",
                                              uid:
                                                  "${users["${posts[index]["uid"]}"]["uid"]}",
                                            )));
                              }
                            },
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 46, 64, 84), size: 15),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${posts[index]["datetime"].substring(0, 16)}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 46, 64, 84),
                    size: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                color: Color.fromARGB(255, 46, 64, 84),
                height: 1,
                thickness: 0.5,
              ),
            ),
            Text(
              "${posts[index]["text"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#startup",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#idea",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#launch_your_career",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (posts[index]["PostImage"] != "")
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        AnimatedPageRoute(
                            widget: PostImage(
                                postimage: "${posts[index]["PostImage"]}")));
                  },
                  child: Hero(
                    tag: 'postimage',
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage("${posts[index]["PostImage"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Icon(
                              TablerIcons.heart,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "${likes[index]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              TablerIcons.message,
                              size: 18,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "0 comments",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Divider(
                color: Color.fromARGB(255, 46, 64, 84),
                height: 1,
                thickness: 0.5,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage("${users[uid]["image"]}"),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Write a comment..."),
                      ],
                    ),
                    onTap: () {
                      DisplayComments(context, postsId[index]);
                    },
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: liked == false
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: Icon(
                                  TablerIcons.heart,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text("Like",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          )
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: Icon(
                                  TablerIcons.heart_broken,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text("Unlike",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                  ),
                  onTap: () {
                    DatabaseService().getLikes(postsId[index]);
                    setState(() {
                      liked = true;
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Icon(
                            TablerIcons.share,
                            size: 20,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("Share",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          if (!verified)
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              margin: EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 5),
                          child: Icon(
                            Icons.info_outlined,
                            color: Color.fromARGB(255, 46, 64, 84),
                          ),
                        ),
                        Text(
                          "Verify your e-mail",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color.fromARGB(255, 46, 64, 84),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8.0, top: 4, bottom: 4),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 46, 64, 84),
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification()
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: 'check your e-mail',
                                backgroundColor:
                                    Color.fromARGB(255, 46, 64, 84),
                                timeInSecForIosWeb: 4);
                          });
                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              verified = true;
                            });
                          });
                        },
                        child: Text(
                          "Send Verification e-mail",
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 210, 224),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            margin: EdgeInsets.all(8.0),
            child: Stack(alignment: AlignmentDirectional.topEnd, children: [
              Image(
                image: ExactAssetImage("assets/images/home.png"),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20),
                child: Text(
                  "Communicate with people",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color.fromARGB(255, 46, 64, 84),
                  ),
                ),
              )
            ]),
          ),
          loading == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    color: Color.fromARGB(255, 190, 210, 224),
                  ),
                )
              : ConditionalBuilder(
                condition: posts.length>0,
                builder:(context)=> ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(context, index);
                    },
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                  ),
                fallback: (context) => Center(
                  child: Column(
                    children:[
                      Icon(Icons.post_add_outlined,size: 80,color:Color.fromARGB(255, 190, 210, 224),),
                      Text("Be the first to post an idea",style: TextStyle(
                        fontSize: 22,
                        fontWeight:FontWeight.w600,
                        color:Color.fromARGB(255, 190, 210, 224),
                      ),)
                    ]
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget emojiselect() {
    return EmojiPicker(
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
      customWidget: (config, state) => CustomView(config, state),
    );
  }

  Widget emoji() {
    return Offstage(
        offstage: !emojiShowing,
        child: SizedBox(
          height: 340,
          child: EmojiPicker(
              onEmojiSelected: (Category category, Emoji emoji) {
                _onEmojiSelected(emoji);
              },
              onBackspacePressed: _onBackspacePressed,
              config: Config(
                  columns: 7,
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  //emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  initCategory: Category.RECENT,
                  bgColor: const Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  progressIndicatorColor: Colors.blue,
                  backspaceColor: Colors.blue,
                  showRecentsTab: true,
                  recentsLimit: 28,
                  noRecentsText: 'No Recents',
                  noRecentsStyle:
                      const TextStyle(fontSize: 20, color: Colors.black26),
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL)),
        ));
  }
}
