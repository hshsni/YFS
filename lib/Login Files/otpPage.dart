import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminHub.dart';
import 'package:youth_compass_application/Login%20Files/ConfirmedPage.dart';
import 'package:youth_compass_application/Login%20Files/MoreDetailsPage.dart';
import 'package:youth_compass_application/Login%20Files/SignUpPhone.dart';
import '../Utils/size_config.dart';

class otpPage extends StatefulWidget {
  const otpPage({Key? key}) : super(key: key);

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
  bool _isProcessing = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please enter the One Time Password that will be sent on your device",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 20.0),
                  child: _isProcessing
                      ? ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 172, 62, 65),
                            ),
                            fixedSize:
                                MaterialStateProperty.all(const Size(180, 50)),
                          ),
                          onPressed: () async {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: SignUpPhone.verify,
                                      smsCode: code);
                              setState(() {
                                _isProcessing = true;
                              });
                              UserCredential userCreds =
                                  await auth.signInWithCredential(credential);
                              User? user = userCreds.user;
                              final docId = FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user?.uid);

                              docId.get().then((DocumentSnapshot doc) {
                                //in case user is already registered
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ConfirmedPage(
                                        user: user,
                                      ),
                                    ),
                                    (route) => false);
                              }, onError: (e) async {
                                await docId.set({
                                  'phone': user?.phoneNumber,
                                  'approved': false
                                });

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MoreDetailsPage(
                                              user: user,
                                            )),
                                    (route) => false);
                              });

                              setState(() {
                                _isProcessing = false;
                              });
                            } catch (e) {
                              setState(() {
                                _isProcessing = false;
                              });
                              final snackBar = SnackBar(
                                content: const Text('Wrong OTP entered'),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'VERIFY',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 172, 62, 65),
                          ),
                        ),
                ),
              ),
              // Row(
              //   children: [
              //     TextButton(
              //         onPressed: () {
              //           Navigator.of(context)
              //               .pushAndRemoveUntil(
              //               MaterialPageRoute(
              //                   builder:
              //                       (context) =>
              //                       AdminHub()),
              //                   (route) => false);
              //         },
              //         child: Text(
              //           "Edit Phone Number?",
              //           style: TextStyle(color: Colors.black),
              //         ))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
