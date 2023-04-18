import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/SchoolCard.dart';
import 'package:youth_compass_application/Admin%20Dash%20Files/Trainer/TrainerCard.dart';

import '../../Utils/AppDrawer.dart';
import '../TaskCard.dart';

class TrainerDash extends StatefulWidget {
  const TrainerDash({Key? key}) : super(key: key);

  @override
  State<TrainerDash> createState() => _TrainerDash();
}

class _TrainerDash extends State<TrainerDash> {
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FirebaseAuth auth = FirebaseAuth.instance;

  updateTextandClear() {
    setState(() {
      _titleTextController.clear();
      _descriptionTextController.clear();
      final snackBar = SnackBar(
        content: const Text('Task Added!'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  updateTextandClear1() {
    setState(() {
      final snackBar = SnackBar(
        content: const Text('Assign Task Successfully!'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  final CollectionReference schools =
      FirebaseFirestore.instance.collection('School');
  final CollectionReference Task =
      FirebaseFirestore.instance.collection('Tasks');
  String selectedClient = "0";

  final _formKey = GlobalKey<FormState>();
  late String _taskName;
  late String _description;
  String _schoolName = "Jyothy Institute of Technology";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Handle form submission
    }
  }

  @override
  void initState() {
    // TODO: implement
    _schoolName = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                          subtitle: Text(documentSnapshot['description']),
                          title: Text(documentSnapshot['title']),
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: const Text(
                                        'Assign Task',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.w300),
                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor:

                                          Color.fromARGB(255, 235, 215, 164),
                                      content: SingleChildScrollView(
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white/* const Color.fromARGB(
                                                        255, 172, 62, 65)*/, //<-- SEE HERE
                                                  ),
                                                  child: StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('Users')
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                                                      List<
                                                              DropdownMenuItem<
                                                                  String>>
                                                          clientItems = [];
                                                      if (!snapshot.hasData) {
                                                        return CircularProgressIndicator();
                                                      } else {
                                                        final clients = snapshot
                                                            .data!.docs.reversed
                                                            .toList();

                                                        clientItems.add(
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: "0",
                                                          child: Text(
                                                              "Select Volunteer"),

                                                        ));

                                                        for (var client
                                                            in clients) {
                                                          clientItems.add(
                                                              DropdownMenuItem<
                                                                  String>(
                                                            value: client.id,
                                                            child: Text(
                                                                client['name']),

                                                          ));

                                                        }
                                                      }
                                                      return DropdownButton<
                                                          String>(
                                                        items: clientItems,

                                                        onChanged: (clientValue) {
                                                          setState(() {
                                                            selectedClient =
                                                                clientValue!;
                                                          });
                                                          print(clientValue);
                                                        },
                                                        icon: Padding( //Icon at tail, arrow bottom is default icon
                                                            padding: EdgeInsets.only(left:20),
                                                            child:Icon(Icons.arrow_circle_down_sharp)
                                                        ),
                                                        iconEnabledColor: Colors.black, //Icon color
                                                        style: TextStyle(  //te
                                                            color: Colors.black, //Font color
                                                            fontSize: 20 //font size on dropdown button
                                                        ),


                                                        dropdownColor: Colors.white, //dropdown background color
                                                        underline: Container(), //remove underline
                                                        isExpanded: true, //make true to make width 100%


                                                        value: selectedClient,

                                                      );

                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 20),

                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color:Colors.white/*const Color.fromARGB(
                                                        255, 172, 62, 65)*/,
                                                  ),
                                                  child: StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('School')
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                                                      List<
                                                              DropdownMenuItem<
                                                                  String>>
                                                          clientItems = [];
                                                      if (!snapshot.hasData) {
                                                        return CircularProgressIndicator();
                                                      } else {
                                                        final clients = snapshot
                                                            .data!.docs.reversed
                                                            .toList();
                                                        clientItems.add(
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: "0",
                                                          child: Text(
                                                              "Select School"),
                                                        ),



                                                        );
                                                        for (var client
                                                            in clients) {
                                                          clientItems.add(
                                                              DropdownMenuItem<
                                                                  String>(
                                                            value: client.id,
                                                            child:
                                                                Text(client.id),

                                                          ),
                                                          );
                                                        }
                                                      }
                                                      return DropdownButton<
                                                          String>(
                                                        items: clientItems,
                                                        onChanged: (clientValue) {
                                                          setState(() {
                                                            selectedClient =
                                                                clientValue!;
                                                          });
                                                          print(clientValue);
                                                        },
                                                        icon: Padding( //Icon at tail, arrow bottom is default icon
                                                            padding: EdgeInsets.only(left:20),
                                                            child:Icon(Icons.arrow_circle_down_sharp)
                                                        ),
                                                        iconEnabledColor: Colors.black, //Icon color
                                                        style: TextStyle(  //te
                                                            color: Colors.black, //Font color
                                                            fontSize: 20 //font size on dropdown button
                                                        ),

                                                        dropdownColor: Colors.white, //dropdown background color
                                                        underline: Container(), //remove underline
                                                        isExpanded: true, //make true to make width 100%

                                                        value: selectedClient,

                                                      );

                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_titleTextController
                                                              .text.isEmpty ||
                                                          _descriptionTextController
                                                              .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Please enter all fields'),
                                                          ),
                                                        );
                                                      } else {
                                                        //adding school to firebase along with email as field
                                                        CollectionReference
                                                            Task =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Tasks');

                                                        Task.doc().set({
                                                          "title":
                                                              _titleTextController
                                                                  .text,
                                                          "description":
                                                              _descriptionTextController
                                                                  .text
                                                        }).then(
                                                            updateTextandClear1());
                                                        if (!mounted) return;
                                                        return Navigator.of(
                                                                context)
                                                            .pop();
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          const Color.fromARGB(
                                                              255, 172, 62, 65),
                                                      fixedSize: Size(
                                                          size.width * 0.40,
                                                          size.height * 0.07),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10), // <-- Radius
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Assign Task',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                          },
                        ),
                      ],
                    ),
                  );
                },
                itemCount: streamSnapshot.data!.docs.length);
          }
          return const Center(child: Text("No schools yet"));
        },
        stream: Task.snapshots(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(65.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text(
                        'Create Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 35, color: Colors.black,fontWeight: FontWeight.w400),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color.fromARGB(255, 235, 215, 164),
                      content: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: _titleTextController,
                                  decoration: InputDecoration(

                                    hintText: 'Enter Task Name',
                                    /*  icon: const Icon(
                                        Icons.person,
                                        color: Colors.redAccent,
                                        size: 45.0,
                                      ),*/
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15),
                                    ),

                                  ),



                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a task name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _taskName = value!;
                                  },

                                ),
                                
                                const SizedBox(height: 20),

                                /*StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("School").snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return Text("Loading.....");
                                      else {
                                        List<DropdownMenuItem> currencyItems = [DropdownMenuItem(child:Text("SelectSchool"))];
                                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                                          DocumentSnapshot snap = snapshot.data!.docs[i];

                                          currencyItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.id,
                                                style: TextStyle(color: Color(0xff11b719)),
                                              ),
                                              value: "${snap.id}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[

                                            DropdownButton<dynamic>(

                                              items: currencyItems,
                                              onChanged: (currencyValue) {
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                    'Selected Currency value is $currencyValue',
                                                    style: TextStyle(color: Color(0xff11b719)),
                                                  ),
                                                );

                                                setState(() {
                                                  _schoolName = currencyValue;
                                                });
                                                print(_schoolName);
                                              },
                                              value: _schoolName,
                                              isExpanded: false,
                                              hint: new Text(
                                                "Choose Currency Type",
                                                style: TextStyle(color: Color(0xff11b719)),
                                              ),
                                            ),
                                          ],
                                        );
                                    }
                                    }

                                  ),*/

                                Container(padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white/*const Color.fromARGB(
                                        255, 172, 62, 65)*/,
                                  ),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('School')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<DropdownMenuItem<String>> clientItems =
                                          [];
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        final clients =
                                            snapshot.data!.docs.reversed.toList();
                                        clientItems.add(DropdownMenuItem<String>(
                                          value: "0",
                                          child: Text("Select School"),
                                        ));
                                        for (var client in clients) {
                                          clientItems
                                              .add(DropdownMenuItem<String>(
                                            value: client.id,
                                            child: Text(client.id),
                                          ));
                                        }
                                      }
                                      return DropdownButton<String>(
                                        items: clientItems,
                                        onChanged: (clientValue) {
                                          setState(() {
                                            selectedClient = clientValue!;
                                          });
                                          print(clientValue);

                                        },
                                        icon: Padding( //Icon at tail, arrow bottom is default icon
                                            padding: EdgeInsets.only(left:20),
                                            child:Icon(Icons.arrow_circle_down_sharp)
                                        ),
                                        iconEnabledColor: Colors.black, //Icon color
                                        style: TextStyle(  //te
                                            color: Colors.black, //Font color
                                            fontSize: 20 //font size on dropdown button
                                        ),

                                        dropdownColor: Colors.white, //dropdown background color
                                        underline: Container(), //remove underline
                                        isExpanded: true,
                                        value: selectedClient,

                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _descriptionTextController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 5,
                                  //Normal textInputField will be displayed
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    /*  icon: const Icon(
                                        Icons.person,
                                        color: Colors.redAccent,
                                        size: 45.0,
                                      ),*/

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
                                  /*validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a task name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _taskName = value!;
                                    },*/
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_titleTextController.text.isEmpty ||
                                          _descriptionTextController
                                              .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
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
                                          "title": _titleTextController.text,
                                          "description":
                                              _descriptionTextController.text
                                        }).then(updateTextandClear());
                                        if (!mounted) return;
                                        return Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 172, 62, 65),
                                      fixedSize: Size(size.width * 0.58,
                                          size.height * 0.09),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // <-- Radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Create Task',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                });
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add_task_sharp),
        ),
      ),
    );
  }
}
