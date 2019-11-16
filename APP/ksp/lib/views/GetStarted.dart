import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/utils/permissions.dart';
import 'package:ksp/views/SignUp.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/bg.jpg"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Welcome to KSP",
                  style: Theme.of(context).textTheme.display1.copyWith(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(50.0),
                child: CircleAvatar(
                  radius: 100.0,
                  child: Image.asset(
                    "assets/seal.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: background,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(50.0),
                child: RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    color: primary,
                    elevation: 5.0,
                    textColor: Colors.white,
                    child: Text(
                      "Get Started",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: _getPermissions),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getPermissions() async {
    PermissionsService().getRequiredPermissions().then((_) {
      _gotoLogin();
    });
  }

  _gotoLogin() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignupPage()));
  }
}
