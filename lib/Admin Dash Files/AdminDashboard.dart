import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/SchoolCard.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/TrainerCard.dart';

import '../Utils/AppDrawer.dart';
import 'TaskCard.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({Key? key}) : super(key: key);

  @override
  State<AdminDash> createState() => _AdminDash();
}

class _AdminDash extends State<AdminDash> {
  List<String> itemList = ["Trainer", "School", "Data Analytics", "Tasks"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      drawer: const AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 60,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    for (var item in itemList)
                      GestureDetector(
                        onTap: () {
                          if (item == "Trainer") {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TrainerCard()));
                            });
                          } else if (item == "School") {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SchoolCard()));
                            });
                          } else if (item == "Tasks") {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TaskCard()));
                            });
                          } else if (item == "Data Analytics") {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SchoolCard()));
                            });
                          }
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
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
                                        item == "Data Analytics"
                                            ? "assets/grade.png"
                                            : "assets/$item.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "3 Items",
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
            ],
          ),
        )),
      ),
    );
  }
}
