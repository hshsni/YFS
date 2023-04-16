import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/Add%20Items/AddSchool.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/View%20Items/ViewSchool.dart';

import '../Utils/AppDrawer.dart';

class SchoolCard extends StatefulWidget {
  const SchoolCard({Key? key}) : super(key: key);

  @override
  State<SchoolCard> createState() => _SchoolCard();
}

class _SchoolCard extends State<SchoolCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'School',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
            ),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color.fromARGB(255,235,215,164),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [

                Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => AddSchool()));
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
                                        Image.asset(
                                          "assets/School.png",
                                          width: 64.0,
                                        ),
                                        SizedBox(height: 16.0),
                                        Text("Add School",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                        SizedBox(height: 5.0),
                                        Text(
                                          "1 Items",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
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
                    padding: const EdgeInsets.all(70.0),
                    child: Center(
                        child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => ViewSchool()));
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
                                          Image.asset(
                                            "assets/School.png",
                                            width: 64.0,
                                          ),
                                          SizedBox(height: 16.0),
                                          Text("View School",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              )),
                                          SizedBox(height: 5.0),
                                          Text(
                                            "1 Items",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
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
                      child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                      ])),
                ),
              ]),
            )));
  }
}