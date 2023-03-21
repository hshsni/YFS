import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youth_compass_application/Login%20Files/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color:Color.fromARGB(255, 172,62,65),
            ),
            child:
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
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Home'),
          //   onTap: () => {},
          // ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            //onTap: _signOut(context),
          ),
          ElevatedButton(onPressed: (){_signOut(context);}, child: Text('Sign Out')),
        ],
      ),
    );
  }

    _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
