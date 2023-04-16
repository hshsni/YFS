import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../Utils/size_config.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdmin();
}

class _AddAdmin extends State<AddAdmin> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FirebaseAuth auth = FirebaseAuth.instance;

  updateTextandClear() {
    //function to clear all textfields and then show a snackbar of success condition
    setState(() {
      _nameTextController.clear();
      _emailTextController.clear();
      _passwordTextController.clear();
      final snackBar = SnackBar(
        content: const Text('Admin Added!'),
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
                          "Add Admin",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 70),
                        TextFormField(
                          controller: _nameTextController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
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
                            hintText: 'Enter Email',
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
                        TextFormField(
                          controller: _passwordTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            icon: Icon(
                              Icons.password,
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
                                  _nameTextController.text.isEmpty ||
                                  _passwordTextController.text.isEmpty) {
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
                                FirebaseApp app = await Firebase.initializeApp(
                                    name: 'secondary', options: Firebase.app().options);

                                User? user;

                                UserCredential userCredential =
                                  await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                );

                                // user = userCredential.user;
                                // await user!.updateDisplayName(
                                //     _nameTextController.text);
                                // await user.reload();
                                // user = auth.currentUser;

                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('Users');

                                users.doc(userCredential.user?.uid).set({
                                  'name': _nameTextController.text,
                                  'role': 'admin',
                                  'email': _emailTextController.text
                                }).then((value) {
                                  updateTextandClear();
                                }).catchError((error) =>
                                    print("Failed to add admin: $error"));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 172, 62, 65),
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
