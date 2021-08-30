import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2k/components/ProfileDrawer.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/helper/helper.dart';
import 'package:w2k/screens/AdminLaunchScreen.dart';
import 'package:w2k/screens/AdminRegistration.dart';
import 'package:w2k/screens/LoginScreen.dart';
import 'package:w2k/screens/RegistrationScreen.dart';
import 'package:w2k/screens/WelcomeScreen.dart';
import 'LunchingScreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomSplash(
        imagePath: 'assets/dustbin.png',
        backGroundColor: kBackground,
        //backGroundColor: Colors.white,
        animationEffect: 'zoom-in',
        logoSize: 100.0,
        duration: 4000,
        home: MaterialApp(
          initialRoute: WelcomeScreen.id,
          routes: {
            //'/': (context) => SplashScreen(),
            WelcomeScreen.id: (context) => WelcomeScreen(),
            AdminRegistration.id: (context) => AdminRegistration(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            LunchingScreen.id: (context) => LunchingScreen(),
            AdminLunchScreen.id: (context) => AdminLunchScreen(),
            ProfileDrawerWidget.id: (context) => ProfileDrawerWidget(),
          },
          //home: WelcomeScreen(),
          //customFunction: duringSplash,
          //type: CustomSplashType.StaticDuration,
          //outputAndHome: op,
        ),
      ),
    );
  }
}
