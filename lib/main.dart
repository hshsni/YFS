import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminHub.dart';
import 'Login Files/login_page.dart';
import 'Admin Dash Files/AdminDashboard.dart';



void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        primarySwatch: Colors.blue,
      ),
      home: AdminHub(),
    );
  }
}