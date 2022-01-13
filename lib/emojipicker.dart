import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'customviewemojis.dart';
class Emoji extends StatelessWidget {
  const Emoji({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color:Colors.blue,
      child: EmojiPicker(
        onEmojiSelected: (emoji, category) {
          print(emoji);
        },
        customWidget: (config, state) => CustomView(config, state),
      ),
    );
  }
}