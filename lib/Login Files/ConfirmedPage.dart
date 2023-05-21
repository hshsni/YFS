import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/AdminHub.dart';
import '../Utils/size_config.dart';
import '../Admin Dash Files/AdminDashboard.dart';
import '../Trainer Files/Trainer_Hub.dart';
import '../Volunteer Files/Volunteer_Hub.dart';

class ConfirmedPage extends StatefulWidget {
  final User? user;
  const ConfirmedPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ConfirmedPage> createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  bool _isLoading = true;

  dataLoadFunction() async {
    setState(() {
      _isLoading = true;
    });
    String type = "";
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        if (documentSnapshot['approved']) {
          type = documentSnapshot['role'];
          if (type == "admin") {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AdminHub()));
          } else if (type == "trainer") {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const TrainerHub()));
          } else if (type == "volunteer") {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const VolunteerHub()));
          }
        }
      } else {
        print('From Confirmed Page');
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataLoadFunction();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      body: _isLoading
          ? CircularProgressIndicator()
          : Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 8,
            vertical: SizeConfig.blockSizeVertical * 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.check,color: Colors.green,
              //     size: 50.0,),
                  Image.asset(
                    'assets/check.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
              Text(
                'Please wait for a few hours for your registration to be verified.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}