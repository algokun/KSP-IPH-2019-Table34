import 'package:flutter/material.dart';
import 'package:ksp/views/GetStarted.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSP HACK19',
      home: GetStarted(),
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'WorkSans'),
      debugShowCheckedModeBanner: false,
    );
  }
}
