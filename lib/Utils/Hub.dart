import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Pages/Homepage.dart';
import 'package:youth_compass_application/Pages/Task.dart';

import '../Pages/Student.dart';

class HubScreen extends StatefulWidget {
  HubScreen({Key? key}) : super(key: key);

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  var screens;

  @override
  void initState() {
    screens = [
      Homepage(),
      Task(),
      Student(),
    ];
    super.initState();
  }

  int index = 0;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.bar_chart, size: 30),
    Icon(Icons.group, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: Key('Nav Bar'),
        items: items,
        height: 62.0,
        index: index,
        onTap: (index) => setState(() => this.index = index),
        color: Colors.white,
        backgroundColor: Color(0x00ffffff),
        animationDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
