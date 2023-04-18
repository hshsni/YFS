import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Feedback1 extends StatefulWidget {
  const Feedback1({Key? key}) : super(key: key);

  @override
  State<Feedback1> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback1> {
Platform ? pickedFile;

//   Future selectFile() async{
//   final result= await FilePicker.platform.pickFiles();
//   if(result == null) return;
//
//   setState(() {
//     pickedFile=result.files.first;
//   });
//   }
//
// Future uploadFile() async {
//    /* final path='files/${pickedFile!.name}';
//     final file =File(pickedFile!.path);*/
//
//     final ref=FirebaseStorage.instance.ref().child(path);
//     ref.putFile(file);
//
//     final snapshot =await uploadTask!.whenComplete(() {});
//     final urlDownlod =await snapshot.ref.getDownloadURL();
//     print('Download Link:$urlDownlod');
//
//
//
// }


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
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor:  Color.fromARGB(255,235,215,164),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           /*if(pickedFile != null)
             Expanded(
               child: Container(
                 color:Colors.blue[100],
                 child: Center(
                   child: Image.file(
                     File(pickedFile!.path),
                     width: double.infinity,
                     fit:BoxFit.cover,
                   )
                 ),
               ),
             ),*/
              const SizedBox(height:35),
              ElevatedButton(
                  child:const Text('SELECT FILE'),
                  onPressed:() {},
              ),
           const SizedBox(height: 35),

           ElevatedButton(
             child:const Text('UPLOAD FILE'),
             onPressed:() {},
           ),
           const SizedBox(height: 35),

         ],



        ),
        ),

      );
  }
}

