import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:istart/net/database.dart';
import 'package:istart/profile.dart';

import 'customviewemojis.dart';

// ignore: must_be_immutable
class Chatdetails extends StatefulWidget {
  String name;
  String surname;
  String image;
  String cover;
  String bio;
  String uid;
  Chatdetails(
    this.name,
    this.surname,
    this.image,
    this.cover,
    this.bio,
    this.uid,
  );

  @override
  State<Chatdetails> createState() => _ChatdetailsState();
}

class _ChatdetailsState extends State<Chatdetails> {
  var message = TextEditingController();
  var messages = [];
  FocusNode focus = FocusNode();
  final TextEditingController _controller = TextEditingController();
  ScrollController _scrolllcontroller = ScrollController();
  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    message
      ..text += emoji.emoji
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: message.text.length));
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
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        DatabaseService().getMessages(receiverId: "${widget.uid}");
        Timer(Duration(milliseconds: 200), () {
          setState(() {
            messages = Messages;
          });
        });
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 46, 64, 84),
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
            // leadingWidth: 25,
            title: InkWell(
              child: Text(
                "${widget.name} ${widget.surname}",
                style: TextStyle(
                  color: Color.fromARGB(255, 46, 64, 84),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                      name: widget.name,
                      surname: widget.surname,
                      profile: widget.image,
                      Cover: widget.cover,
                      bio: widget.bio,
                      uid: widget.uid,
                    ),
                  ),
                );
              },
            ),

            leading: InkWell(
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage("${widget.image}"),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: InkWell(
                          child: Text("Change Wallpaper"),
                          onTap: () {},
                        ),
                        value: 'Change wallpaper',
                      )
                    ];
                  })),
            ],
          ),
          body: WillPopScope(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/chatwallpaper.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      showTrackOnHover: true,
                      radius: Radius.circular(20),
                      thickness: 3,
                      hoverThickness: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10),
                        child: ConditionalBuilder(
                          condition: messages.length > 0,
                          builder: (context) {
                            return ListView.separated(
                                controller: _scrolllcontroller,
                                itemBuilder: (context, index) {
                                  var message = messages[index];
                                  if (message["reveiverId"] != widget.uid) {
                                    return buildmessage(message);
                                  } else {
                                    return buildMymessage(message);
                                  }
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 5,
                                    ),
                                itemCount: Messages.length);
                          },
                          fallback: (context) => Container(),
                        ),
                      ),
                    ),
                  ),
                  Column(
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
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: TextFormField(
                                      focusNode: focus,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 46, 64, 84),
                                        fontSize: 18,
                                      ),
                                      controller: message,
                                      cursorColor:
                                          Color.fromARGB(255, 46, 64, 84),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        //filled: true,
                                        //fillColor: Color.fromARGB(255, 190, 210, 224),
                                        hintText: 'Type your message...',
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromARGB(255, 46, 64, 84),
                                            fontSize: 18),
                                        prefixIcon: IconButton(
                                          color:
                                              Color.fromARGB(255, 46, 64, 84),
                                          focusColor:
                                              Color.fromARGB(255, 46, 64, 84),
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
                                              focus.canRequestFocus = false;
                                              setState(() {
                                                emojiShowing = !emojiShowing;
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
                                  color: Color.fromARGB(255, 190, 210, 224),
                                ),
                                height: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    _scrolllcontroller.animateTo(
                                        _scrolllcontroller
                                            .position.maxScrollExtent,
                                        duration: Duration(microseconds: 100),
                                        curve: Curves.easeOut);
                                    DatabaseService().SendMessage(
                                        receiverId: "${widget.uid}",
                                        datetime: DateTime.now().toString(),
                                        text: message.text);
                                    setState(() {
                                      message = TextEditingController();
                                    });
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    Icons.send,
                                    size: 25,
                                    color: Color.fromARGB(255, 46, 64, 84),
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
                ],
              ),
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
        );
      },
    );
  }

  Widget buildmessage(message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 55, 134, 150),
                    Color.fromARGB(255, 190, 210, 224),
                  ],
                ),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(
                "${message["text"]}         ",
                style: TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0, right: 3.0),
              child: Text(
                "${message["datetime"].substring(11,16)}",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 46, 64, 84),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMymessage(message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 55, 134, 150),
                      Color.fromARGB(255, 190, 210, 224),
                    ],
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    bottomStart: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: Text(
                  "${message["text"]}             ",
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromARGB(255, 46, 64, 84),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 5,bottom: 2.0, right: 3.0),
                    child: Text(
                      "${message["datetime"].substring(11,16)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 46, 64, 84).withOpacity(0.7)
                      ),
                    ),
                  ),
                  Padding(
                padding: const EdgeInsets.only(top:5,bottom: 2.0, right: 3.0),
                child: Icon(TablerIcons.checks,color: Color.fromARGB(255, 46, 64, 84).withOpacity(0.7),size:18)
              ),
                ],
              ),
            ],
          )),
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
