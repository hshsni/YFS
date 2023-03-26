import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminDashboard.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/TaskCard.dart';
import 'SchoolCard.dart';

class AdminHub extends StatefulWidget {
  const AdminHub({Key? key}) : super(key: key);

  @override
  State<AdminHub> createState() => _AdminHubState();
}

class _AdminHubState extends State<AdminHub> {
  var screens;

  @override
  void initState() {
    screens = [
      AdminDash(),
      TaskCard(),
      SchoolCard(),
      TaskCard(),
    ];
    super.initState();
  }

  int index = 0;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.bar_chart, size: 30),
    Icon(Icons.school, size: 30),
    Icon(Icons.task, size: 30),
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
