import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:istart/net/flutterfire.dart';

class CustomWidgets {
  static Widget socialButtonCircle(color, icon, {iconColor, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor,
          )), //
    );
  }
}

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 70, right: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidgets.socialButtonCircle(
              Color.fromARGB(255, 46, 64, 84), FontAwesomeIcons.facebookF,
              iconColor: Colors.white, onTap: () async {
            bool shouldnavigate = await facebooksingin();
            if (shouldnavigate) {
              Navigator.of(context).pushReplacementNamed('/e');
            }
            //Fluttertoast.showToast(msg: 'I am circle facebook');
          }),
          CustomWidgets.socialButtonCircle(
              Color.fromARGB(255, 46, 64, 84), FontAwesomeIcons.googlePlusG,
              iconColor: Colors.white, onTap: () async {
            bool shouldnavigate = await googlesignin();
            if (shouldnavigate) {
              Navigator.of(context).pushReplacementNamed('/e');
            }
            //Fluttertoast.showToast(msg: 'I am circle google');
          }),
          CustomWidgets.socialButtonCircle(
              Color.fromARGB(255, 46, 64, 84), FontAwesomeIcons.linkedin,
              iconColor: Colors.white, onTap: () {
            //Fluttertoast.showToast(msg: 'I am circle LinkedIn');
          }),
        ],
      ),
    );
  }
}
