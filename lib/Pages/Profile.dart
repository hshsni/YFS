import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../Utils/size_config.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  bool _isLoading = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  final Name = TextEditingController();
  final Email = TextEditingController();
  final Role = TextEditingController();

  loadProfile() {
    setState(() {
      _isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Name.text = "Name: ${documentSnapshot['name']}";
        Email.text = "Email: ${documentSnapshot['email']}";
        Role.text = "Role: ${documentSnapshot['role']}";
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    loadProfile();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 215, 164),
      appBar: AppBar(
        toolbarHeight: 60,
        // auth.currentUser.uid
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: SizeConfig.screenHeight / 7.5),
                child: SingleChildScrollView(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                "My Profile",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 70),
                              TextFormField(
                                readOnly: true,
                                controller: Name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: Email,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: Role,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
