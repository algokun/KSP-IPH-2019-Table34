import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/utils/bloc/loginBloc.dart';
import 'package:ksp/utils/userHandling.dart';
import 'package:ksp/views/SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ColorConfig {
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

  final loginBloc = LoginBloc();

  TextEditingController email, password;
  TextStyle textform = TextStyle(fontSize: 10.0, fontFamily: 'WorkSans');

  static final _formKey = GlobalKey<FormState>();
  static final _key = GlobalKey<ScaffoldState>();

  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signUpText = Text(
      'Login',
      style: styleHead,
    );

    final emailSignUp = Container(
      decoration: BoxDecoration(
          color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
      child: StreamBuilder<String>(
          stream: loginBloc.email,
          builder: (context, snapshot) {
            return TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onChanged: loginBloc.emailChanged,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorText: snapshot.error,
                  hintText: 'Enter your Email',
                  labelText: 'Email',
                ));
          }),
    );
    final passSignUp = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: StreamBuilder<String>(
            stream: loginBloc.password,
            builder: (context, snapshot) {
              return TextField(
                onChanged: loginBloc.passwordChanged,
                controller: password,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter Your password',
                    labelText: 'Password'),
              );
            }));

    final signUpButton = StreamBuilder<bool>(
        stream: loginBloc.submitCheck,
        builder: (context, snapshot) {
          return Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFFFF9800),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: snapshot.hasData ? () => signInUser(context) : null,
              child: Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: styleButton,
              ),
            ),
          );
        });

    final login = FlatButton(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignupPage()));
      },
      child: Text(
        "Don't have an account?",
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange),
      ),
    );

    List<Widget> list1 = [
      signUpText,
      emailSignUp,
      passSignUp,
      signUpButton,
      login
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

  signInUser(BuildContext c) async {
    String emailText = email.text;
    String passwordText = password.text;
    Auth auth = Auth.fromContext(context: c);
    await auth.signInUser(emailText, passwordText);
  }
}
