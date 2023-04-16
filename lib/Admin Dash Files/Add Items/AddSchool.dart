import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/size_config.dart';

class AddSchool extends StatefulWidget {
  const AddSchool({Key? key}) : super(key: key);

  @override
  State<AddSchool> createState() => _AddSchool();
}

class _AddSchool extends State<AddSchool> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FirebaseAuth auth = FirebaseAuth.instance;

  updateTextandClear() {
    setState(() {
      _nameTextController.clear();
      _emailTextController.clear();
      final snackBar = SnackBar(
        content: const Text('School Added!'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          '',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: SizeConfig.screenHeight / 6),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "Add School",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 70),
                        TextFormField(
                          controller: _nameTextController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Enter School Name',
                            icon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
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
                            hintText: 'Enter School Email',
                            icon: const Icon(
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
                          height: 50,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_emailTextController.text.isEmpty ||
                                  _nameTextController.text.isEmpty) {
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
                                //adding school to firebase along with email as field
                                CollectionReference school = FirebaseFirestore
                                    .instance
                                    .collection('School');

                                school
                                    .doc(_nameTextController.text)
                                    .set({"email": _emailTextController.text});
                                updateTextandClear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 172, 62, 65),
                              fixedSize:
                                  Size(size.width * 0.58, size.height * 0.09),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'Add',
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
