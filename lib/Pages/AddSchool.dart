import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils/AppDrawer.dart';

class AddSchool extends StatefulWidget {
  const AddSchool({Key? key}) : super(key: key);

  @override
  State<AddSchool> createState() => _AddSchool();
}

class _AddSchool extends State<AddSchool> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255,235,215,164),
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Add School',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameTextController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Enter School Name',
                              icon: Icon(
                                Icons.person,
                                color: Colors.amber,
                                size: 45.0,
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
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
                              icon: Icon(
                                Icons.email,
                                color: Colors.amber,
                                size: 45.0,
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
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
                              hintText: 'Enter School Password',
                              icon: Icon(
                                Icons.password,
                                color: Colors.amber,
                                size: 45.0,
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
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
                            height: 70,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_emailTextController.text.isEmpty ||
                                    _nameTextController.text.isEmpty ||
                                    _passwordTextController.text.isEmpty) {
                                  SnackBar(
                                    content: Text('Please enter all fields'),
                                  );
                                }
                                if (!emailRegExp
                                    .hasMatch(_emailTextController.text)) {
                                  SnackBar(
                                    content: Text('Please enter proper email'),
                                  );
                                }

                                User? user;

                                UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                );

                                user = userCredential.user;
                                await user!.updateDisplayName(
                                    _nameTextController.text);
                                await user.reload();
                                user = auth.currentUser;

                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('Users');

                                users.add({
                                  'name': _nameTextController.text,
                                  'role': 'subadmin'
                                }).then((value) {
                                  print("User Added");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const AddSchool()));
                                }).catchError((error) =>
                                    print("Failed to add user: $error"));
                              },
                              style: ElevatedButton.styleFrom( primary: Color.fromARGB(255, 172,62,65),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}