import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksp/views/CreateProfile.dart';
import 'package:ksp/views/HomePage.dart';

class Auth {
  final BuildContext context;
  Auth.fromContext({this.context});

  Future createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CreateProfile()));
      });
    } on PlatformException catch (e) {
      showError(e.message);
    }
  }

  Future signInUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      });
    } on PlatformException catch (e) {
      showError(e.message);
    }
  }

  showError(String error) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color(0xFF54595E),
              title: Text("Ouch!!"),
              content: Text(error),
              actions: <Widget>[
                FlatButton(
                  child: Text("Retry"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
