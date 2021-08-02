import 'package:w2k/constants.dart';
import 'package:w2k/screens/login_screen.dart';
import 'package:w2k/screens/registration_screen.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimarycolor.withOpacity(controller.value),
      backgroundColor: kPrimarycolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Hero(
                //   tag: 'icon',
                //   child: Container(
                //     child: Image.asset('assets/icon.png'),
                //     height: animation.value * 100,
                //   ),
                // ),
                Container(
                  child: Image.asset('assets/icon.png'),
                  //height: animation.value * 100,
                  height: 100.0,
                ),
                TypewriterAnimatedTextKit(
                  text: ['Waste Kiya Kya!'],
                  textStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: const Duration(milliseconds: 200),
                  //to slower the animation.
                  repeatForever: true,          //to stop the animation repeating forever.
                  //totalRepeatCount: 1,        //to define how many times the animation will repeat.
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              title: 'Log in',
              colour: Colors.orange,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },),
            RoundedButton(
              title: 'Registration',
              colour: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

