import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
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

class Nothing extends StatefulWidget {
  @override
  _NothingState createState() => _NothingState();
}

class _NothingState extends State<Nothing> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/bg.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height / 3,
              decoration: BoxDecoration(
                color: background,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(100.0),
              child: RaisedButton(
                color: primary,
                elevation: 5.0,
                child: Text("Get Started"),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
