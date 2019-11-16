// import 'package:flutter/material.dart';
// import 'package:ksp/utils/userRepo.dart';
// import 'package:ksp/views/GetStarted.dart';
// import 'package:ksp/views/Splash.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       builder: (_) => UserRepository.instance(),
//       child: Consumer(
//         builder: (context, UserRepository user, _) {
//           switch (user.status) {
//             case Status.Uninitialized:
//               return SplashScreen();
//             case Status.Unauthenticated:
//             case Status.Authenticating:
//               return GetStarted();
//             case Status.Authenticated:
//               return UserInfoPage(user: user.user);
//           }
//         },
//       ),
//     );
//   }
// }