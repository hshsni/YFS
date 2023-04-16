import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppDrawer.dart';

class ViewTrainer extends StatefulWidget {
  const ViewTrainer({Key? key}) : super(key: key);

  @override
  State<ViewTrainer> createState() => _ViewTrainer();
}

class _ViewTrainer extends State<ViewTrainer> {
  final CollectionReference trainers = FirebaseFirestore.instance
      .collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          title: const Text(
            'View Trainer',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
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

                    if(documentSnapshot['role']=='trainer') {
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
          stream: trainers.snapshots(),
        ),
        );
  }
}
