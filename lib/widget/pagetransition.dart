import 'package:flutter/cupertino.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimatedPageRoute({required this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);

            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
        );
}
