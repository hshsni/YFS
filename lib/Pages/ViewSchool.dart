import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Pages/AddAdmin.dart';

import '../Admin Dash Files/AdminHub.dart';
import '../Utils/AppDrawer.dart';

class ViewSchool extends StatefulWidget {
  const ViewSchool({Key? key}) : super(key: key);

  @override
  State<ViewSchool> createState() => _ViewSchool();
}

class _ViewSchool extends State<ViewSchool> {
  final CollectionReference schools = FirebaseFirestore.instance
      .collection('School');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        title: const Text(
          'View Schools',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
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
