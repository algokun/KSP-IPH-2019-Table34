import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/views/GetStarted.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    bool loggedIn = user != null;
    return loggedIn ? Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50.0),
        child: CircleAvatar(
          radius: 100.0,
          child: Image.asset(
            "assets/seal.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    ) : GetStarted();
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(50.0),
//         child: CircleAvatar(
//           radius: 100.0,
//           child: Image.asset(
//             "assets/seal.png",
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }
