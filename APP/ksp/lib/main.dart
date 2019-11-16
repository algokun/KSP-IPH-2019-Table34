import 'package:flutter/material.dart';
import 'package:ksp/views/HomePage.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSP HACK19',
      home: Nothing(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Nothing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/bg.jpg")
        ],
      ),
    );
  }
}