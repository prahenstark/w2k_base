import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/reward.png', height: 200.0, width: 200.0),
              Text(
                'Your total reward is',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '4.8 units',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}