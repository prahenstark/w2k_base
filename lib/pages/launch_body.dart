import 'package:flutter/material.dart';

class LaunchBody extends StatefulWidget {
  @override
  _LaunchBodyState createState() => _LaunchBodyState();
}

class _LaunchBodyState extends State<LaunchBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home1.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        // child: Center(
        //   child: Text(
        //     'Welcome',
        //     style: TextStyle(
        //         fontSize: 30
        //     ),),
        // ),
      ),
    );
  }
}