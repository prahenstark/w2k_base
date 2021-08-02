import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:w2k/screens/login_screen.dart';
import 'package:w2k/screens/lunching_screen.dart';
import 'package:w2k/screens/registration_screen.dart';
import 'package:w2k/screens/splash_screen.dart';
import 'package:w2k/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //initialRoute: SplashScreen.id,
      // routes: {
      //   //'/': (context) => SplashScreen(),
      //   WelcomeScreen.id: (context) => WelcomeScreen(),
      //   LoginScreen.id: (context) => LoginScreen(),
      //   RegistrationScreen.id: (context) => RegistrationScreen(),
      //   '/launch': (context) => LunchingScreen(),
      // },
    );
  }
}
