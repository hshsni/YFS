import 'package:flutter/material.dart';

import '../Utils/AppDrawer.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key ? key}) : super(key:key);
  @override
  State<TaskCard>createState() =>_TaskCard();
}
class _TaskCard extends State<TaskCard>
{
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:const Color.fromARGB(255,235,215,164),
      appBar: AppBar(

        toolbarHeight: 60,
        foregroundColor: Colors.black,
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black
          ),
        ),
        centerTitle: true,

        backgroundColor: Colors.transparent,
        elevation:0,
      ),
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
                            hintText: 'Name of the Volunteer',
                            icon: Icon(Icons.person,color: Colors.amber,size: 45.0,),

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
                            hintText: 'Name of the Schools',
                            icon: Icon(Icons.school_sharp,color: Colors.amber,size: 45.0,),

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
                            hintText: 'Area of the Schools',
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
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {

                            });
                          },
                          /* onSubmitted: (value) =>
                              convert(double.parse(value), _time), */
                          decoration: InputDecoration(
                            hintText: 'Volunteer Id',
                            icon: Icon(Icons.format_list_numbered_rtl_sharp,color: Colors.amber,size: 45.0,),
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
                              'Assign Task',
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
