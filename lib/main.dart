import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w2k/model/DustbinModel.dart';
import 'package:w2k/providers/DustbinProvider.dart';
import 'package:w2k/screens/SplashScreen.dart';
import 'providers/UserProvider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider()),
        ChangeNotifierProvider(create: (_)=> DustbinProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        //bottomAppBarColor: Colors.green,
        //fontFamily: 'Poppins',
      ),
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
