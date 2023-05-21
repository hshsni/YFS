import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../Utils/size_config.dart';

class AppFeedback extends StatefulWidget {
  const AppFeedback({Key? key}) : super(key: key);

  @override
  State<AppFeedback> createState() => _AppFeedback();
}

class _AppFeedback extends State<AppFeedback> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FeedbackText = TextEditingController();

  clearFeedback() {
    setState(() {
      FeedbackText.clear();
      final snackBar = SnackBar(
        content: const Text('Feedback Sent!'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 215, 164),
      appBar: AppBar(
        toolbarHeight: 60,
        // auth.currentUser.uid
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: SizeConfig.screenHeight / 7.5),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "App Feedback",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 70),
                        TextFormField(
                          controller: FeedbackText,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                            // hintText: 'Enter Feedback',
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
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (FeedbackText.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter feedback'),
                                  ),
                                );
                              } else {
                                //adding school to firebase along with email as field
                                CollectionReference feedback = FirebaseFirestore
                                    .instance
                                    .collection('Feedback');

                                feedback
                                    .add({"description": FeedbackText.text});
                                clearFeedback();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 172, 62, 65),
                              fixedSize:
                                  Size(size.width * 0.58, size.height * 0.09),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
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
}
