import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ColorConfig {
  int _selectedIndex = 0;

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: <Widget>[
            Container(
              child: Text("Hello"),
            ),
            Container(
              child: Text("World"),
            ),
            Container(
              child: Text("Its me"),
            ),
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
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Users'),
                activeColor: Colors.purpleAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text('Messages'),
                activeColor: Colors.pink),
            BottomNavyBarItem(
                icon: Icon(Icons.settings),
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
