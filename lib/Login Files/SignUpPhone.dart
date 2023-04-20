import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminHub.dart';
import 'package:youth_compass_application/Login%20Files/SignUpEmail.dart';
import 'package:youth_compass_application/Login%20Files/login_page.dart';
import '../Utils/size_config.dart';
import 'fire_auth.dart';
import 'otpPage.dart';

class SignUpPhone extends StatefulWidget {
  const SignUpPhone({Key? key}) : super(key: key);

  static String verify = "";
  @override
  State<SignUpPhone> createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final _registerFormKey = GlobalKey<FormState>();

  final _phoneTextController = TextEditingController();

  final _focusPhone = FocusNode();

  bool _isProcessing = false;

  String? validatePhone({required String? phone}) {
    if (phone == null) {
      setState(() {
        _isProcessing = false;
      });
      return null;
    }

    RegExp phoneRegExp = RegExp(r"^[0-9]{10}$");

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _focusPhone.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        //const Color.fromARGB(255, 235, 215, 164),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 9,
              ),
              Text(
                "Welcome to YouthCompass!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 4.0,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5.0),
              //email text box
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
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneTextController,
                            focusNode: _focusPhone,
                            validator: (value) => validatePhone(
                              phone: value,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
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
                        const SizedBox(height: 30.0),
                        if (_isProcessing)
                          const CircularProgressIndicator()
                        else
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
                                        borderRadius: BorderRadius.circular(12),
                                      )),
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

                                      sendOtpMsg(_phoneTextController.text.trim());
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: const Center(
                                        child: Text(
                                          'SIGN UP',
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
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                              SizeConfig.blockSizeHorizontal*13),
                          child: Row(
                            children: [
                              const Center(
                                child: Text(
                                  "Already have an account?",
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
                                          builder: (_) => const LoginPage()));
                                },
                                child: Text(
                                  "Sign In",
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
                        const Center(
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
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
                                        SizeConfig.blockSizeHorizontal * 10.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                    backgroundColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          const Color.fromARGB(255, 172, 62, 65),
                                    ),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(180, 50)),
                                  ),
                                  onPressed: ()
                                  {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const SignUpEmail()));
                                  },
                                  child: const SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Sign Up with Email instead',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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

  sendOtpMsg(String phone) async {
    String countryCode = '+91';
    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      phoneNumber: countryCode + phone,
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken)
      {
        SignUpPhone.verify = verificationId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const otpPage()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
