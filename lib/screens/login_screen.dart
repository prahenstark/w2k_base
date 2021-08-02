import 'package:firebase_auth/firebase_auth.dart';
import 'package:w2k/components/rounded_button.dart';
import 'package:w2k/constants.dart';
//import 'package:w2k/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:w2k/screens/lunching_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      // body: ModalProgressHUD(
      //   inAsyncCall: showSpinner,
      //   child: Padding(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Flexible(
            //   child: Hero(
            //     tag: 'icon',
            //     child: Container(
            //       height: 140.0,
            //       child: Image.asset('images/icon.png'),
            //     ),
            //   ),
            // ),
            Flexible(
              child: Container(
                height: 140.0,
                child: Image.asset('assets/icon.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your e-mail'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log in',
              colour: Colors.deepOrange,
              // onPressed: () {
              //   Navigator.pushNamed(context, LunchingScreen.id);
              //},
              onPressed: () async{
                setState(() {
                  showSpinner = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, LunchingScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
    //);
  }
}
