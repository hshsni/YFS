import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Feedback1 extends StatefulWidget {
  const Feedback1({Key? key}) : super(key: key);

  @override
  State<Feedback1> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback1> {

  List<File> images = [];

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 60,
      title: const Text(
        'Feedback',
        style: TextStyle(
            fontSize: 30,
            color: Colors.black
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
      backgroundColor:  Color.fromARGB(255,235,215,164),
      body: Container(

    ),
    );
  }
}

