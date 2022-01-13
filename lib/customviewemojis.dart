import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
class CustomView extends EmojiPickerBuilder {
    CustomView(Config config, var state) : super(config, state);

    @override
    _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
    @override
    Widget build(BuildContext context) {
        return Container();
    }
}