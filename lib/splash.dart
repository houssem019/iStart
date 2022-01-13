import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istart/gettingstarted.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: 80,
          animationDuration: Duration(milliseconds: 1500),
          duration: 3000,
          backgroundColor: Color.fromARGB(255, 46, 64, 84),
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: Pview(),
          splash: Image(
            image: ExactAssetImage("assets/images/log.png"),
          )),
    );
  }
}
