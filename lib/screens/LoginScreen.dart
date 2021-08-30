import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:w2k/components/rounded_button.dart';
import 'package:w2k/constants.dart';
import 'package:flutter/material.dart';
import 'package:w2k/model/UserModel.dart';
import 'package:w2k/providers/UserProvider.dart';
import 'package:w2k/screens/LunchingScreen.dart';

import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  String email;
  String password;
  //UserModel userModel = UserModel();

  double latitude;
  double longitude;
  String address;
  Position _currentPosition;
  String _currentAddress = "";

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
      debugPrint('location: ${position.latitude}');
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.adminArea} : ${first.addressLine}");
      print(coordinates.longitude);
      print(coordinates.latitude);

      latitude = coordinates.latitude;
      longitude = coordinates.longitude;
      address = addresses.first.addressLine.toString();

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackground,
      //backgroundColor: Colors.white,
      // body: ModalProgressHUD(
      //   inAsyncCall: showSpinner,
      //   child: Padding(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            // SizedBox(
            //   height: 140,
            // ),
            Flexible(
              child: Container(
                height: 100.0,
                child: Image.asset('assets/dustbin.png'),
              ),
            ),
            SizedBox(
              height: 55.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimarycolor,
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              indent: 5,
              endIndent: 210,
              color: Colors.black54,
            ),
            SizedBox(
              height: 25.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your e-mail',
                prefixIcon: Icon(Icons.email),
              ),
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
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.vpn_key_rounded),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log in',
              colour: kPrimarycolor,
              //colour: Color.fromARGB(255, 2, 144, 93),
              onPressed: () {
                Navigator.pushNamed(context, LunchingScreen.id);
                // if(latitude == null) {
                //     return Center(
                //       child: CircularProgressIndicator(
                //         backgroundColor: Colors.deepOrange,
                //       ),
                //     );
                //   }
              },
              // onPressed: () async {
              //   setState(() {
              //     showSpinner = true;
              //   });
              //   try {
              //     final user = await _auth.signInWithEmailAndPassword(
              //         email: email, password: password);
              //     if (user != null) {
              //       _firestore
              //           .collection('user')
              //           .where('email', isEqualTo: email)
              //           .get()
              //           .then((QuerySnapshot querySnapshot) {
              //         querySnapshot.docs.forEach((doc) {
              //           UserModel userModel = UserModel.fromJson(doc.data());
              //           Provider.of<UserProvider>(context,listen: false).setUser(userModel);
              //           print(userModel.name);
              //         });
              //       });
              //
              //       Navigator.pushNamed(context, LunchingScreen.id);
              //
              //       //.then((querySnapshot.data.map(json)) => UserModel.fromJson(json).toList());
              //       //     .then((snapshot) => UserModel.fromJson(snapshot.docs[].data()));
              //       // print(userModel.name)
              //
              //     }
              //     setState(() {
              //       showSpinner = false;
              //     });
              //   } catch (e) {
              //     print(e);
              //   }
              // },
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
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(color: kTextColor)),
                    TextSpan(
                        text: "Registor",
                        style: TextStyle(color: kPrimarycolor)),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
    //);
  }
}
