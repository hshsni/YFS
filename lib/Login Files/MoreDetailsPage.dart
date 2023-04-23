import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../Utils/size_config.dart';

class MoreDetailsPage extends StatefulWidget {
  final User? user;
  const MoreDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MoreDetailsPage> createState() => _MoreDetailsPage();
}

class _MoreDetailsPage extends State<MoreDetailsPage> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FirebaseAuth auth = FirebaseAuth.instance;

  updateTextandClear() {
    //function to clear all textfields and then show a snackbar of success condition
    setState(() {
      _nameTextController.clear();
      _emailTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 215, 164),
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          "",
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
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "A few more details we'd like from you...",
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        SizedBox(height: 70),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameTextController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            icon: const Icon(
                              Icons.person,
                              color: Colors.amber,
                              size: 45.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Colors.amber,
                              size: 45.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_emailTextController.text.isEmpty ||
                                  _nameTextController.text.isEmpty ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter all fields'),
                                  ),
                                );
                              }
                              if (!emailRegExp
                                  .hasMatch(_emailTextController.text)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please enter proper email'),
                                ));
                              } else {
                                //add role field with radio buttons
                                  DocumentReference docRef = FirebaseFirestore.instance.
                                  collection('Users').doc(widget.user?.uid);

                                  //document to update with name, email and role of user
                                  docRef.update({
                                    'name': _nameTextController.text,
                                    'email': _emailTextController.text
                                  });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 172, 62, 65),
                              fixedSize:
                              Size(size.width * 0.58, size.height * 0.09),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
