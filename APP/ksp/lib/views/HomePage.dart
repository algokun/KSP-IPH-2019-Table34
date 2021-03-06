import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/utils/fcm.dart';
import 'package:ksp/views/Tasks/DummyTasks.dart';
import 'package:provider/provider.dart';

import 'Chats/ChatHome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ColorConfig, FCMHandler {
  int _selectedIndex = 0;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
        onMessage: (map) => onMessage(map),
        onLaunch: (map) => onLaunch(map),
        onResume: (map) => onResume(map));

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    firebaseMessaging.getToken().then((token) {
      Firestore.instance
          .collection("tokens")
          .document(user.uid)
          .setData({'fcmToken': token});
    });

    return Scaffold(
        backgroundColor: background,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: <Widget>[
            ChatHome(),
            Container(
              child: Text("Its me"),
            ),
            TaskList(),
            Container(
              child: Text("Mohan"),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: lowContrast,
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('Chats'),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.group),
                title: Text('Groups'),
                activeColor: Colors.purpleAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.timer),
                title: Text('Tasks'),
                activeColor: Colors.pink),
            BottomNavyBarItem(
                icon: Icon(Icons.track_changes),
                title: Text('Settings'),
                activeColor: Colors.blue),
          ],
        ));
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
