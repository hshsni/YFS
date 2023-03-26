import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Admin Dash Files/AdminDashboard.dart';
import 'Admin Dash Files/AdminHub.dart';
import 'Login Files/login_page.dart';
import 'Pages/AddAdmin.dart';
import 'Pages/AddSchool.dart';
import 'Pages/AddTrainer.dart';

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
      home: LoginPage(),
    );
  }
}