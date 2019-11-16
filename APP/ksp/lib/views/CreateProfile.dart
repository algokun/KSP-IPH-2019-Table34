import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> with ColorConfig{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Create Profile"),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}