import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksp/views/Splash.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF323538),
  ));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged)
      ],
      child: MaterialApp(
        title: 'KSP HACK19',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            fontFamily: 'WorkSans',
            backgroundColor: Color(0xFF323538),
            primaryColor: Colors.orange),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
