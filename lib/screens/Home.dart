import 'package:doctor_appointments/screens/screens.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  List<Widget> widgetList = const [
    HomeScreen(),
    Schedule(),
    PatientProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child: widgetList[_current],),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _current,
        backgroundColor: Constants.primaryBgColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (val) {
          setState(() {
            _current = val;
          });

        },
      ),
    );
  }
}
