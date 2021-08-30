import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2k/components/RounderButton_2.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/helper/helper.dart';
import 'package:w2k/screens/AdminRegistration.dart';
import 'package:w2k/screens/LoginScreen.dart';
import 'package:w2k/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:w2k/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // AnimationController controller;
  // Animation animation;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller = AnimationController(
  //     duration: Duration(seconds: 5),
  //     vsync: this
  //   );
  //   animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
  //   controller.forward();
  //   controller.addListener(() {
  //     setState(() {});
  //   });

  int _deviceState;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  Future<void> enableGps() async {
    if (await Geolocator.isLocationServiceEnabled() == false) {
      Geolocator.openLocationSettings();
    }
  }

  @override
  void initState() {
    enableGps();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    BluetoothHelper.enableBluetooth(_bluetoothState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      //backgroundColor: kPrimarycolor.withOpacity(controller.value),
      //backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Flexible(
                child: Container(
                  height: 130.0,
                  child: Image.asset('assets/dustbin.png'),
                ),
              ),
              SizedBox(height: 50,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome , Choose your ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimarycolor,
                          fontSize: 27),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      endIndent: 25,
                      color: Colors.black54,
                    ),
                    Text(
                      "position !",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimarycolor,
                          fontSize: 27),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      endIndent: 200,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Row(
              //   children: <Widget>[
              //     // Hero(
              //     //   tag: 'icon',
              //     //   child: Container(
              //     //     child: Image.asset('assets/icon.png'),
              //     //     height: animation.value * 100,
              //     //   ),
              //     // ),
              //     Container(
              //       child: Image.asset('assets/dustbin.png'),
              //       //height: animation.value * 100,
              //       height: 100.0,
              //     ),
              //     TypewriterAnimatedTextKit(
              //       text: ['Waste Kiya Kya!'],
              //       textStyle: TextStyle(
              //         color: Color.fromARGB(255,87,190,146),
              //         fontSize: 30.0,
              //         fontWeight: FontWeight.w800,
              //       ),
              //       speed: const Duration(milliseconds: 200),
              //       //to slower the animation.
              //       repeatForever: true,          //to stop the animation repeating forever.
              //       //totalRepeatCount: 1,        //to define how many times the animation will repeat.
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 40.0,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton2(
                    title: 'User',
                    colour: kPrimarycolor,
                    //colour: Color.fromARGB(255, 2, 144, 93),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  SizedBox(width: 40.0,),
                  RoundedButton2(
                    title: 'Admin',
                    //colour: kPrimarycolor,
                    colour: Color.fromARGB(255, 87, 190, 146),
                    onPressed: () {
                      Navigator.pushNamed(context, AdminRegistration.id);
                    },
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: kBackground,
                  //color: Colors.white,
                  //width: 50,
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Choose an ",
                          style: TextStyle(color: kTextColor)),
                      TextSpan(
                          text: "Option",
                          style: TextStyle(color: kPrimarycolor)),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
