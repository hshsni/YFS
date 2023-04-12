import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminHub.dart';
import 'package:youth_compass_application/Login%20Files/login_page.dart';
import 'size_config.dart';
import 'fire_auth.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final _registerFormKey = GlobalKey<FormState>();

  final _clgTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  int _groupValue = 1;
  bool _isAdmin = false;

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

  String? validateCollege({required String? clg}) {
    if (clg == null) {
      return null;
    }

    if (clg.isEmpty) {
      return 'Please select a school';
    } else if (clg.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  String dropdownvalue = 'Select a School';

  // List of items in our dropdown menu


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 215, 164),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 10,
              ),
              const Center(
                child: Text(
                  "Welcome To",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Youth Compass!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

              ),
              const SizedBox(height: 20), //email text box
              Form(
                key: _registerFormKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => validateEmail(
                              email: value,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: true,
                            validator: (value) => validatePassword(
                              password: value,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(52, 73, 85, 1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),


                        const SizedBox(height: 30.0),


                        const SizedBox(height: 30.0),
                        if (_isProcessing)
                          const CircularProgressIndicator()
                        else
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateColor.resolveWith(
                                            (states) => const Color.fromARGB(255, 172, 62, 65),

                                      ),
                                      fixedSize: MaterialStateProperty.all(const Size(180, 50)),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FireAuth
                                            .registerUsingEmailPassword(
                                          email: _emailTextController.text,
                                          clg: dropdownvalue,
                                          password:
                                              _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });
                                        final docid = FirebaseFirestore.instance
                                            .collection('userdata')
                                            .doc(user?.uid);

                                        await docid.set({
                                          'email': user?.email,
                                          'college': dropdownvalue,
                                          'type': _isAdmin ? 'Admin' : 'Student'
                                        });
                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>AdminHub()
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      child: const Center(
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 15.0),
                        const Center(
                          child: Text(
                            "Do you have Account ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                        ),
                        const SizedBox(height: 30.0),

                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateColor.resolveWith(
                                            (states) => const Color.fromARGB(255, 172, 62, 65),

                                      ),
                                      fixedSize: MaterialStateProperty.all(const Size(180, 50)),
                                    ),
                                    onPressed: ()  {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => LoginPage()));
                                                   },


                                    child: Container(
                                      height: 40,
                                      child: const Center(
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}

class ChildWidget extends StatefulWidget {
  final Function() notifyParent;

  ChildWidget({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
