import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/screens/login_screen.dart';
import 'package:w2k/screens/registration_screen.dart';
import 'package:w2k/screens/welcome_screen.dart';
import 'lunching_screen.dart';

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
        imagePath: 'assets/icon.png',
        backGroundColor: kPrimarycolor,
        animationEffect: 'zoom-in',
        logoSize: 500.0,
        duration: 4000,
        home: MaterialApp(
          initialRoute: WelcomeScreen.id,
          routes: {
            //'/': (context) => SplashScreen(),
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LunchingScreen.id: (context) => LunchingScreen(),
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
