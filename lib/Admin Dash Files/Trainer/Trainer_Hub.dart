import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/TaskCard.dart';

import 'package:youth_compass_application/Admin%20Dash%20Files/Trainer/tr_dashboard.dart';
import 'package:youth_compass_application/Pages/ViewTask.dart';


class TrainerHub extends StatefulWidget {
  const TrainerHub({Key? key}) : super(key: key);

  @override
  State<TrainerHub> createState() => _TrainerHubState();
}

class _TrainerHubState extends State<TrainerHub> {
  var screens;

  @override
  void initState() {
    screens = [
      TrainerDash(),

      ViewTask(),
    ];
    super.initState();
  }

  int index = 0;

  final items = <Widget>[
    Icon(Icons.view_agenda_outlined, size: 30),
    Icon(Icons.assignment_ind_outlined,size: 30,)

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
