import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youth_compass_application/Login%20Files/ConfirmedPage.dart';
import 'package:youth_compass_application/main.dart';

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

  bool _isNamePresent = false;
  bool _isEmailPresent = false;
  bool _isRolePresent = false;

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
  void initState()
  {
    super.initState();
    FirebaseFirestore.instance.
    collection('Users').doc(widget.user!.uid).get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        if(documentSnapshot['name'] != null) {
          _isNamePresent = true;
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("username", documentSnapshot['name']);
        }
        if(documentSnapshot['email'] != null)
          _isEmailPresent = true;
        if(documentSnapshot['role'] != null)
          _isRolePresent = true;

        if(_isEmailPresent && _isNamePresent && _isRolePresent)
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => ConfirmedPage()));

      } else {
        print('Document does not exist on the database');
      }
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
        child: 
        Column(
            children: [
              Form(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "A few more details we'd like from you...",
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        SizedBox(height: 70),
                        !_isNamePresent ? TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameTextController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                        hintText: 'Name',
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
                        ) : SizedBox(),
                        const SizedBox(
                          height: 30,
                        ),
                        !_isEmailPresent ? TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon:Icon(
                              Icons.email,
                            ),
                        hintText: 'Email',
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
                        ) : SizedBox(),
                        !_isRolePresent? RadioForRole() : SizedBox(),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if ((!_isEmailPresent && _emailTextController.text.isEmpty) ||
                                  (!_isNamePresent && _nameTextController.text.isEmpty) ) {
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
                                    'email': _emailTextController.text,
                                    'role': RadioForRole.role
                                  });

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) => ConfirmedPage()));
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
    );
  }
}

class RadioForRole extends StatefulWidget {
  static String role = "";
  const RadioForRole({Key? key}) : super(key: key);
  @override
  State<RadioForRole> createState() => _RadioForRoleState();
}

class _RadioForRoleState extends State<RadioForRole> {
  Role _role = Role.volunteer;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Volunteer'),
            leading: Radio<Role>(
              fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
              focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
              value: Role.volunteer,
              groupValue: _role,
              onChanged: (Role? value) {
                setState(() {
                  _role = value!;
                  RadioForRole.role = value! as String;
                });
              },
            ),
          ),
        ),
        Expanded(child: ListTile(
          title: const Text('Trainer'),
          leading: Radio<Role>(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: Role.trainer,
            groupValue: _role,
            onChanged: (Role? value) {
              setState(() {
                _role = value!;
                RadioForRole.role = value! as String;
              });
            },
          ),
        )),
      ],
    );
  }
}
