import 'package:flutter/material.dart';
class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
        'Create Task',
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
        backgroundColor: Color.fromARGB(255,235,215,164),
        body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              children:[
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {

                              });
                            },
                            /* onSubmitted: (value) =>
                              convert(double.parse(value), _time), */
                            decoration: InputDecoration(
                              hintText: 'Title of the Task',
                              icon: Icon(Icons.task_alt,color: Colors.amber,size: 45.0,),

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {

                              });
                            },
                            /* onSubmitted: (value) =>
                              convert(double.parse(value), _time), */
                            decoration: InputDecoration(
                              hintText: 'Description of the task',
                              icon: Icon(Icons.perm_identity,color: Colors.amber,size: 45.0,),

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {

                              });
                            },
                            /* onSubmitted: (value) =>
                              convert(double.parse(value), _time), */
                            decoration: InputDecoration(
                              hintText: 'School Name',
                              icon: Icon(Icons.location_city_sharp,color: Colors.amber,size: 45.0,),

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          const SizedBox(
                            height: 70,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                /*  convert(_power, _time);*/
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
                                'Create Task',
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
