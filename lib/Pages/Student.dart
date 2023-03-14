import 'package:flutter/material.dart';
import 'package:youth_compass_application/Utils/AppDrawer.dart';

class Student extends StatefulWidget {
  const Student({Key ? key}) : super(key:key);
  @override
  State<Student>createState() =>_Student();
}
class _Student extends State<Student>
{
  @override
  Widget build(BuildContext context)
  {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Students',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(child: Column(
          children:[
            Padding(
                padding: const EdgeInsets.all(40.0),
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
                          hintText: 'Name of the Student',
                          icon: const Icon(Icons.person,color: Colors.amber,size: 45.0,),
                          hintStyle: const TextStyle(color: Colors.white),
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
                          icon: const Icon(Icons.school_sharp,color: Colors.amber,size: 45.0,),
                          hintStyle: const TextStyle(color: Colors.white),
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
                          hintText: 'Roll Number',
                          icon: const Icon(Icons.numbers,color: Colors.amber,size: 45.0,),
                          hintStyle: const TextStyle(color: Colors.white),
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
                        fixedSize: Size(size.width*0.58, size.height*0.09),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        'Add Student',
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
