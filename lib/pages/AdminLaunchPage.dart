import 'package:flutter/material.dart';
import 'package:w2k/constants.dart';

class AdminLaunchPage extends StatefulWidget {
  @override
  _AdminLaunchPageState createState() => _AdminLaunchPageState();
}

class _AdminLaunchPageState extends State<AdminLaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kHomecolor,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/home1.jpeg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
        //   ),
        // ),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                child: Text('Hello', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 50.0),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}