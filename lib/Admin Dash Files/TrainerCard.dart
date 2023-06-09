import 'package:flutter/material.dart';
import 'ApproveTrainer.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/Add%20Items/AddTrainer.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/View%20Items/ViewTrainer.dart';

import '../../Utils/AppDrawer.dart';

class TrainerCard extends StatefulWidget {
  const TrainerCard({Key? key}) : super(key: key);

  @override
  State<TrainerCard> createState() => _TrainerCard();
}

class _TrainerCard extends State<TrainerCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'Trainer',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color.fromARGB(255, 235, 215, 164),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AddTrainer()));
                        });
                      },
                      child: SizedBox(
                          width: 250.0,
                          height: 180.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 30.0),
                                    Image.asset(
                                      "assets/Trainer.png",
                                      width: 64.0,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Add Trainer",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ApproveTrainer()));
                        });
                      },
                      child: SizedBox(
                          width: 250.0,
                          height: 180.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 30.0),
                                    Image.asset(
                                      "assets/Trainer.png",
                                      width: 64.0,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Approve Trainer",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ViewTrainer()));
                      });
                    },
                    child: SizedBox(
                        width: 250.0,
                        height: 180.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 30.0),
                                  Image.asset(
                                    "assets/Trainer.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text("View Trainer",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ]))),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [])),
            ),
          ]),
        )));
  }
}
