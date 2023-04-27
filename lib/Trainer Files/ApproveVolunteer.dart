import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Utils/size_config.dart';

class ApproveVolunteer extends StatefulWidget {
  const ApproveVolunteer({Key? key}) : super(key: key);

  @override
  State<ApproveVolunteer> createState() => _ApproveTrainer();
}

class _ApproveTrainer extends State<ApproveVolunteer> {
  String selectedClient = "Select Volunteer";
  FirebaseAuth auth = FirebaseAuth.instance;

  updateTextandClear() {
    //function to clear all textfields and then show a snackbar of success condition
    setState(() {
      selectedClient = "Select Volunteer";
      final snackBar = SnackBar(
        content: const Text('Volunteer Approved!'),
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
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "Approve Volunteer",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 70),
                        const SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('role', isEqualTo: 'volunteer')
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<DropdownMenuItem<String>> clientItems = [];
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              final clients =
                              snapshot.data!.docs.reversed.toList();
                              clientItems.add(
                                DropdownMenuItem<String>(
                                  value: "Select Volunteer",
                                  child: Text("Select Volunteer"),
                                ),
                              );
                              for (var client in clients) {
                                try {
                                  if (!client.get("approved"))
                                    clientItems.add(
                                      DropdownMenuItem<String>(
                                        value: client.id,
                                        child: Text(client.get("name")),
                                      ),
                                    );
                                } catch (e) {
                                  continue;
                                }
                              }
                            }
                            return DropdownButton<String>(
                              items: clientItems,
                              value: selectedClient,
                              onChanged: (clientValue) {
                                setState(() {
                                  selectedClient = clientValue!;
                                });
                              },
                              dropdownColor:
                              Colors.white, //dropdown background color
                              underline: Container(), //remove underline
                              isExpanded: true, //make true to make width 100%
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (selectedClient == "Select Volunteer") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select a trainer'),
                                  ),
                                );
                              } else {
                                var collection = FirebaseFirestore.instance
                                    .collection('Users');
                                collection
                                    .doc(
                                    selectedClient) // <-- Doc ID where data should be updated.
                                    .update(
                                    {'approved': true}) // <-- Updated data
                                    .then((_) => ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text('Approved Volunteer!'),
                                  ),
                                ))
                                    .catchError((error) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Error!'),
                                      ),
                                    ));
                                updateTextandClear();
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
                              'Approve',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
