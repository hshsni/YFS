import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Login%20Files/SignUpEmail.dart';
import 'package:youth_compass_application/Login%20Files/SignUpPhone.dart';
import 'package:youth_compass_application/Login%20Files/ConfirmedPage.dart';
import 'Login Files/login_page.dart';
import 'Login Files/otpPage.dart';

enum Role {trainer, volunteer}
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidDebugProvider: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youth Compass',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.blue,
      ),
      home: SignUpEmail(),
    );
  }
}