import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Login%20Files/SignUpPhone.dart';

import '../Admin Dash Files/AdminHub.dart';
import '../Utils/size_config.dart';
import 'fire_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  var college;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var collection = FirebaseFirestore.instance.collection('userdata');
      var querySnapshot =
          await collection.where('id', isEqualTo: user.uid).get();
      for (var snapshot in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();
        college = data['college'];
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AdminHub(),
        ),
      );
    }

    return firebaseApp;
  }

  String? validateEmail({required String? email}) {
    if (email == null) {
      setState(() {
        _isProcessing = false;
      });
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      setState(() {
        _isProcessing = false;
      });
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      setState(() {
        _isProcessing = false;
      });
      return 'Enter a correct email';
    }

    setState(() {
      _isProcessing = false;
    });
    return null;
  }

  String? validatePassword({required String? password}) {
    if (password == null) {
      setState(() {
        _isProcessing = false;
      });
      return null;
    }

    if (password.isEmpty) {
      setState(() {
        _isProcessing = false;
      });
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      setState(() {
        _isProcessing = false;
      });
      return 'Enter a password with length at least 6';
    }

    setState(() {
      _isProcessing = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 4.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(height: SizeConfig.blockSizeVertical * 5.0),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => validateEmail(
                              email: value,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height:SizeConfig.blockSizeVertical * 2.0),
                          TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: true,
                            validator: (value) => validatePassword(
                              password: value,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: SizeConfig.blockSizeVertical * 7.0),
                          _isProcessing
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.blockSizeHorizontal *
                                                  20.0,
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                            backgroundColor:
                                                MaterialStateColor
                                                    .resolveWith(
                                              (states) =>
                                                  const Color.fromARGB(
                                                      255, 172, 62, 65),
                                            ),
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    const Size(180, 50)),
                                          ),
                                          onPressed: () async {
                                            _focusEmail.unfocus();
                                            _focusPassword.unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isProcessing = true;
                                              });

                                              User? user = await FireAuth
                                                  .signInUsingEmailPassword(
                                                email:
                                                    _emailTextController.text,
                                                password:
                                                    _passwordTextController
                                                        .text,
                                              );

                                              setState(() {
                                                _isProcessing = false;
                                              });

                                              if (user != null) {
                                                try {} on FirebaseAuthException catch (e) {
                                                  if (e.code ==
                                                      'weak-password') {
                                                  } else if (e.code ==
                                                      'email-already-in-use') {
                                                  } else if (e.code ==
                                                      'user-not-found') {
                                                  } else if (e.code ==
                                                      'wrong-password') {}

                                                  print(e
                                                      .code); //Add this line to see other firebase exceptions.
                                                } catch (e) {
                                                  print(e);
                                                }
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AdminHub()),
                                                        (route) => false);
                                              }
                                            }
                                          },
                                          child: Text(
                                            'SIGN IN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: SizeConfig.blockSizeVertical * 3.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                              height: SizeConfig.blockSizeVertical * 3.0),
                           Center(
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeVertical * 3.0,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.blockSizeHorizontal *
                                              20.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      )),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 172, 62, 65),
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(180, 50)),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SignUpPhone()));
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig.blockSizeVertical * 3.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
