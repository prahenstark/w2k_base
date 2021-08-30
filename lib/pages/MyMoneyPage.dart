import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/providers/DustbinProvider.dart';
import 'package:w2k/providers/UserProvider.dart';

import 'HistoryPage.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:image_ink_well/image_ink_well.dart';

class MyMoneyPage extends StatefulWidget {
  @override
  _MyMoneyPageState createState() => _MyMoneyPageState();
}

class _MyMoneyPageState extends State<MyMoneyPage> {
  HistoryPage _historyPage = new HistoryPage();

  // Widget myNewButton(String myImage) {
  //   return Container();
  // return CircleImageInkWell(
  //   image: AssetImage(myImage),
  //   onPressed: () {
  //     print("Tapped");
  //   },
  //   size: 47,
  // );
  //}

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kHomecolor,
        //color: Color.fromARGB(40,9,167,109),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/home1.jpeg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
        //   ),
        // ),
        child: Center(
          child: Container(
            width: 300.0,
            height: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: kBackground,
              //color: Colors.white70
              //color: Colors.deepOrange.shade300.withOpacity(0.55),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Total Reward',
                    style: TextStyle(color: kTextColor,fontSize: 30),
                  ),
                ),
                Image.asset('assets/reward.png', height: 200.0, width: 200.0),
                Text(
                  'Your total reward is',
                  style: TextStyle(color: kTextColor,fontSize: 25),
                ),
                Text(
                  //'4.8 units',
                    Provider.of<DustbinProvider>(context,listen: false).sum.toString(),
                  style: TextStyle(color: kTextColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}