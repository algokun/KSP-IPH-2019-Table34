import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/views/CreateProfile.dart';
import 'package:ksp/views/HomePage.dart';
import 'package:ksp/views/LoginPage.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ColorConfig {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        Timer(Duration(seconds: 2), gotoLogin);
      } else {
        if (user.displayName == null || user.displayName.isEmpty) {
          Timer(Duration(seconds: 2), gotoProfile);
        } else {
          Timer(Duration(seconds: 2), gotoHome);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      child: Center(
        child: FlatButton.icon(
          onPressed: null,
          icon: Icon(
            Icons.polymer,
            size: 50,
            color: Colors.blue,
          ),
          label: Text(
            "KSP",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  gotoHome() async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  gotoLogin() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  gotoProfile() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CreateProfile()));
  }
}
