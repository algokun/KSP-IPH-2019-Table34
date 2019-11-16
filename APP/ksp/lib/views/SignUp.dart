import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final styleHead = TextStyle(
      color: Colors.white,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none,
      fontSize: 40);
  final styleButton = TextStyle(
    color: Colors.white,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontSize: 20,
  );
  TextEditingController email, password;
  TextStyle textform = TextStyle(fontSize: 10.0, fontFamily: 'WorkSans');

  static final _formKey = GlobalKey<FormState>();
  static final _key = GlobalKey<ScaffoldState>();

  void initState() {
    setState(() {
      email = TextEditingController();
      password = TextEditingController();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpText = Text(
      'SignUp',
      style: styleHead,
    );

    final emailSignUp = TextFormField(
      controller: email,
      validator: (String val) {
        if (val.isEmpty) {
          return 'Please enter your email';
        } else if (!val.contains('@')) {
          return 'Your Email is invalid';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: 'Enter your Email',
        labelText: 'Email',
      ),
    );
    final passSignUp = TextFormField(
      controller: email,
      validator: (String val) {
        if (val.isEmpty) {
          return 'Please enter your password';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: 'Enter Your password',
        labelText: 'Password'
      ),
    );

    final signUpButton = Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFFFF9800),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: (){},
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: styleButton,
              ),
            ),
          );

    List<Widget> list1 = [
      signUpText,
      emailSignUp,
      passSignUp,
      signUpButton
      ];
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFF323538),
      body: Form(
        key: _formKey,

        child: Center(
          child: ListView.separated(
            padding: EdgeInsets.all(30.0),
            itemCount: list1.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return list1[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 30.0,
              );
            },
          ),
        ),
      ),
    );
  }
}
