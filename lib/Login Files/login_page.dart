import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Login%20Files/SignUpEmail.dart';
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

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var collection = FirebaseFirestore.instance.collection('Users');
      var querySnapshot =
          await collection.where('id', isEqualTo: user.uid).get();

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
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 215, 164),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.waiting) {
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
                                                  context: context
                                                );

                                                setState(() {
                                                  _isProcessing = false;
                                                });

                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AdminHub()),
                                                          (route) => false);
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                  SizeConfig.blockSizeHorizontal*13),
                              child: Row(
                                children: [
                                  const Center(
                                    child: Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => const SignUpEmail()));
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
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
      ),
    );
  }
}
