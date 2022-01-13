import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:istart/net/database.dart';
import 'package:istart/widget/inputemail.dart';
import 'package:istart/widget/name.dart';
import 'package:istart/widget/suname.dart';

var name = Name.name;
var surname = Surname.surname;
var Email = InputEmail.inputemail;
var Errors = [];

Future<bool> facebooksingin() async {
  try {
    await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> facebooksingout() async {
  try {
    await FacebookAuth.instance.logOut();
  } catch (e) {
    print(e);
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(signInOption: SignInOption.standard);

Future<bool> googlesignin() async {
  try {
    await _googleSignIn.signIn();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> googlesignout() async {
  try {
    await _googleSignIn.signOut();
  } catch (e) {
    print(e);
  }
}

Future<bool> signin(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    Errors.add(e);
    return false;
  }
}

Future<bool> signup(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //var user = result.user;
    await DatabaseService().updateUserData(name.text, surname.text, Email.text);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    return false;
  }
}
