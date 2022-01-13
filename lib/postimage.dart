import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostImage extends StatelessWidget {
  String postimage;
  PostImage({required this.postimage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'postimage',
          child: Container(
            
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(image: NetworkImage(postimage),fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
