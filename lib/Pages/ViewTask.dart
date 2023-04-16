import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../Admin Dash Files/AdminHub.dart';
import '../Utils/AppDrawer.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTask();
}

class _ViewTask extends State<ViewTask> {
  final CollectionReference schools = FirebaseFirestore.instance
      .collection('School');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Login Approval',
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
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          subtitle: Text(documentSnapshot['email']),
                          title: Text(documentSnapshot.id.toString()),
                        ),
                      ],
                    ),
                  );

                },
                itemCount: streamSnapshot.data!.docs.length);
          }
          return const Center(child: Text("No schools yet"));
        },
        stream: schools.snapshots(),
      ),
    );
  }
}
