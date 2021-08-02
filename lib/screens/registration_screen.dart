import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:w2k/components/rounded_button.dart';
import 'package:w2k/constants.dart';
import 'package:flutter/material.dart';
import 'package:w2k/screens/lunching_screen.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User currentUser;
  bool showSpinner = false;
  String name;
  String phoneNumber;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      // body: ModalProgressHUD(
      //   inAsyncCall: showSpinner,
      //   child:
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 140.0,
                child: Image.asset('assets/icon.png'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your name', ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your phone number', ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your e-mail', ),
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
              title: 'Register',
              colour: Colors.deepOrange,
              // onPressed: () {
              //   Navigator.pushNamed(context, LunchingScreen.id);
              // },
              onPressed: () async{
                // setState(() {
                //   showSpinner = true;
                // });
                print(email);
                print(password);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(newUser != null) {
                    currentUser = _auth.currentUser;
                    Navigator.pushNamed(context, LunchingScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                }
                catch (e) {
                  print(e);
                };


                _firestore.collection('user').add({
                  'name': name,
                  'phone': phoneNumber,
                  'email': email,     //add this
                  'password': password,
                });
              },
            ),
          ],
        ),
      ),
    );
    //);
  }
}
