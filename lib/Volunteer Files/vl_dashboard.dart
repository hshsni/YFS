import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/SchoolCard.dart';
import '../../Utils/AppDrawer.dart';
import 'Feedback.dart';

class volunteerDash extends StatefulWidget {
  const volunteerDash({Key? key}) : super(key: key);

  @override
  State<volunteerDash> createState() => _volunteerDash();
}

class _volunteerDash extends State<volunteerDash> {
  final CollectionReference schools = FirebaseFirestore.instance
      .collection('School');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // Change the color here
        ),

        toolbarHeight: 60,
        elevation: 0,
        title: const Text(
          'Dashboard',
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
                          onTap: () => {Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Feedback1()))},
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
