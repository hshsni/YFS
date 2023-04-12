import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Pages/AddAdmin.dart';

import '../Utils/AppDrawer.dart';

class View_Admin extends StatefulWidget {
  const View_Admin({Key? key}) : super(key: key);

  @override
  State<View_Admin> createState() => _View_Admin();
}

class _View_Admin extends State<View_Admin> {
  final CollectionReference admins = FirebaseFirestore.instance
      .collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'View Admin',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color.fromARGB(255,235,215,164),
        body: StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                    if(documentSnapshot['role']=='admin') {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Text(documentSnapshot['email']) ,
                              title: Text(documentSnapshot['name']),
                            ),
                          ],
                        ),
                      );
                    }
                    else{
                      return const SizedBox.shrink();
                    }
                  },
                  itemCount: streamSnapshot.data!.docs.length);
            }
            return const Center(child: Text("No trainers yet"));
          },
          stream: admins.snapshots(),
        )
      ,
    );
  }
}