import 'package:flutter/material.dart';
import 'package:youth_compass_application/Pages/Admin.dart';
import 'package:youth_compass_application/Pages/Grade.dart';
import 'package:youth_compass_application/Pages/School.dart';
import 'package:youth_compass_application/Pages/Score.dart';
import 'package:youth_compass_application/Pages/Student.dart';
import 'package:youth_compass_application/Pages/Task.dart';

import '../Utils/AppDrawer.dart';
import 'AddSubAdmin.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _Dashboard();
}

class _Dashboard extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Dashboard',
          style: TextStyle(
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
                  child: Center(
                      child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Admin()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                      const SizedBox(height: 16.0),
                                      const Text("Admin",
                                          style:  TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "3 Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const School()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                        "assets/school.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text("College",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "20 Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Task()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                        "assets/task.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text("Task",
                                          style:  TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "40 Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Student()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                        "assets/student.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text("Student",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "300 Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const AddSubAdmin()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                        "assets/score.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text("Score",
                                          style:  TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "300 Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Grade()));
                          });
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: const Color.fromARGB(255, 21, 21, 21),
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
                                        "assets/grade.png",
                                        width: 64.0,
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text("Grade",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        "300 Items",
                                        style:  TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )))
            ],
          ),
        )),
      ),
    );
  }
}
