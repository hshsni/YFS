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

  final _nameTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusPhone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
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

  String? validatePhone({required String? phone}) {
    if (phone == null) {
      setState(() {
        _isProcessing = false;
      });
      return null;
    }

    RegExp phoneRegExp = RegExp(
        r"^[0-9]{10}$");

    if (phone.isEmpty) {
      setState(() {
        _isProcessing = false;
      });
      return 'Phone no. can\'t be empty';
    } else if (!phoneRegExp.hasMatch(phone)) {
      setState(() {
        _isProcessing = false;
      });
      return 'Enter a correct phone number';
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

  String? validateName({required String? name}) {
    if (name == null) {
      setState(() {
        _isProcessing = false;
      });
      return null;
    }
    if (name.isEmpty) {
      setState(() {
        _isProcessing = false;
      });
      return 'Please enter name';
    }
    return null;
  }

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
        backgroundColor: const Color.fromARGB(255, 235, 215, 164),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 9,
              ),
               Center(
                child: Text(
                  "Welcome to",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical*4.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Center(
                child: Text(
                  "Youth Compass!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical*4.0,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*5.0), //email text box
              Form(
                key: _registerFormKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameTextController,
                            focusNode: _focusName,
                            validator: (value) => validateName(
                              name: value,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneTextController,
                            focusNode: _focusPhone,
                            validator: (value) => validatePhone(
                              phone: value,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Phone No.',
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5.0),
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
                        if (_isProcessing)
                          const CircularProgressIndicator()
                        else
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.blockSizeHorizontal*20.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                          )
                                      ),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 172, 62, 65),
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(180, 50)),
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
                                          name: _nameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });
                                        final docid = FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(user?.uid);

                                        await docid.set({
                                          'name': user?.displayName,
                                          'email': user?.email,
                                          'role': 'volunteer'
                                        });
                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminHub()),
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
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.blockSizeHorizontal*20.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        )
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => const Color.fromARGB(
                                          255, 172, 62, 65),
                                    ),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(180, 50)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const LoginPage()));
                                  },
                                  child: const SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
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

