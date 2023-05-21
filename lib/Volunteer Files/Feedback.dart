import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import '../../Utils/button.dart';
import '../Utils/size_config.dart';
import 'api/firebase_api.dart';



class Feedback1 extends StatefulWidget {
  final String id;
  const Feedback1({Key? key,required this.id}) : super(key: key);
  static final String title = 'Firebase Upload';
  @override
  State<Feedback1> createState() => _Feedback1State();
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.green),

  );
}


class _Feedback1State extends State<Feedback1> {
  final  _formKey = GlobalKey<FormState>();
  updateTextandClear() {
    setState(() {

      _descriptTextController.clear();
      final snackBar = SnackBar(
        content: const Text('Feedback  Added!'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    });
  }
  UploadTask? task;
  File? file;
  final _descriptTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
      body:
      Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*8,vertical: SizeConfig.blockSizeVertical*8),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enter the feedback',style: TextStyle(
                      fontSize: 30,
                      color: Colors.black
                  ),),
                  SizedBox(height: SizeConfig.blockSizeVertical*5),
                  TextFormField(
                    controller: _descriptTextController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    //Normal textInputField will be displayed
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*5),
                  ButtonWidget(
                    text: 'Select File',
                    icon: Icons.attach_file,
                    onClicked: selectFile,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*5),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),



                  SizedBox(height: SizeConfig.blockSizeVertical*5),
                  ButtonWidget(
                    text: 'Submit',
                    icon: Icons.send_rounded,
                    onClicked: uploadFile,
                  ),

                  task != null ? buildUploadStatus(task!) : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(()=> file =File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!) ;
    setState(() {});

    //adding school to firebase along with email as field
    CollectionReference Task =
    FirebaseFirestore.instance
        .collection('Feedback');

    Task.doc().set({

      "description":
      _descriptTextController.text
    }).then(updateTextandClear());
    /*if (!mounted) return;
    return Navigator.of(context as BuildContext).pop();*/

    /*if { (file? ||
        _descriptTextController
            .text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext)
          .showSnackBar(
        const SnackBar(
          content:
          Text('Please enter all fields'),
        ),
      );
    } else {
      //adding school to firebase along with email as field
      CollectionReference Task =
      FirebaseFirestore.instance
          .collection('Tasks');

      Task.doc().set({

        "description":
        _descriptTextController.text
      }).then(updateTextandClear());
      if (!mounted) return;
      return Navigator.of(context as BuildContext).pop();
    }
  },*/

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

  }
}



Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  },
);



