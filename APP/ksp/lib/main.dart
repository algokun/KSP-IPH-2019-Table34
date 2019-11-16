import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ksp/config/colors.dart';
import 'package:ksp/views/SignUp.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSP HACK19',
      home: Signup(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Nothing extends StatefulWidget {
  @override
  _NothingState createState() => _NothingState();
}

class _NothingState extends State<Nothing> with ColorConfig {
  final styleBold = TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1);
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
              alignment: Alignment.center,
              height: height / 3,
              decoration: BoxDecoration(
                color: background,
              ),
              padding: EdgeInsets.all(100),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(5.0),
                shadowColor: primary,
                color: primary,
                child: MaterialButton(
                  onPressed: (){},
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: Text('Get Started', style: styleBold,),
                  
                ),
              ),
            ),
          )
        ],
=======
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
>>>>>>> 82e553fbf10a4488265c919d8617f35839ce74de
      ),
    );
  }
}
