import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/TaskCard.dart';
import 'package:youth_compass_application/Volunteer%20Files/vl_dashboard.dart';

import 'Feedback.dart';


class VolunteerHub extends StatefulWidget {
  const VolunteerHub({Key? key}) : super(key: key);

  @override
  State<VolunteerHub> createState() => _VolunteerHubState();

}

class _VolunteerHubState extends State<VolunteerHub> {
  final CollectionReference schools = FirebaseFirestore.instance
      .collection('School');
  var screens;

  @override
  void initState() {
    screens = [
      volunteerDash(),

    ];
    super.initState();
  }

  int index = 0;

  final items = <Widget>[
    Icon(Icons.view_agenda_sharp, size: 30),


  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
