import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/utils/permissions.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with ColorConfig {
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
            color: Colors.orange,
            colorBlendMode: BlendMode.multiply,
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
                  onPressed: _getPermissions),
            ),
          )
        ],
      ),
    );
  }

  _getPermissions() async {
    await PermissionsService().requestCameraPermission();
    await PermissionsService().requestLocationPermission();
    await PermissionsService().requestStoragePermission();
    await PermissionsService().requestContactsPermission();
  }
}
