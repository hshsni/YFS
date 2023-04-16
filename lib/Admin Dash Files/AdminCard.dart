import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/Add%20Items/AddAdmin.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/View%20Items/View_SubAdmin.dart';
import '../Utils/AppDrawer.dart';

class AdminCard extends StatefulWidget {
  const AdminCard({Key? key}) : super(key: key);

  @override
  State<AdminCard> createState() => _AdminCard();
}

class _AdminCard extends State<AdminCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'Admin',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor:  Color.fromARGB(255,235,215,164),
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
                              MaterialPageRoute(builder: (_) => AddAdmin()));
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
                                      "assets/Admin.png",
                                      width: 64.0,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Add Admin",
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
                padding: const EdgeInsets.all(1.0),
                child: Center(
                    child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => View_Admin()));
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
                                    "assets/Admin.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text("View Sub Admin",
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
