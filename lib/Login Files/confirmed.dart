import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart';

import '../../Utils/button.dart';
import '../Utils/size_config.dart';


class Confirmed extends StatefulWidget {
  const Confirmed({Key? key}) : super(key: key);
  static final String title = 'Firebase Upload';
  @override
  State<Confirmed> createState() => _ConfirmedState();
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.green),

  );
}


class _ConfirmedState extends State<Confirmed> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          '',
          style: TextStyle(
              fontSize: 30,
              color: Colors.black
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor:  Color.fromARGB(255,235,215,164),
      body:
      Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*8,vertical: SizeConfig.blockSizeVertical*8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            /*  Icon(Icons.check,color: Colors.green,
                size: 50.0,),*/
              Image.asset(
                'assets/check.png',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
     Text('Great! Your registration is successful. Please wait for a few hours for your registration to be verified.',
       textAlign: TextAlign.center,     style: TextStyle(
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







