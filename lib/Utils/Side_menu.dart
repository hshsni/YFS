import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Side_menu extends StatefulWidget {
  const Side_menu({Key ? key}) : super(key:key);
  @override
  State<Side_menu>createState() =>_Side_menu();
}
class _Side_menu extends State<Side_menu>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        width: 288,
          height:double.infinity,
          color:Color(0xFF17203A),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white24,
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
                ),
                title: Text(
                  "Abhishek Kumar",
                  style: TextStyle(color: Colors.white),),
                subtitle: Text
                  ("Admin",
                  style: TextStyle(color: Colors.white),),
                ),
              SizedBox(height: 30.0),
              ListTile(
               leading: SizedBox(
                 height: 34,
                 width: 34,

               ),

              ),
            ],
          ),
        ),
        )
    );
  }
}

