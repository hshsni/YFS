import 'package:flutter/material.dart';
import '../Utils/size_config.dart';

class ConfirmedPage extends StatefulWidget {
  const ConfirmedPage({Key? key}) : super(key: key);

  @override
  State<ConfirmedPage> createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 215, 164),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 8,
            vertical: SizeConfig.blockSizeVertical * 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*  Icon(Icons.check,color: Colors.green,
                size: 50.0,),*/
              Image.asset(
                'assets/check.png',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
              Text(
                'Great! Your registration is successful. Please wait for a few hours for your registration to be verified.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
