import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:w2k/components/rounded_button.dart';
import 'package:w2k/constants.dart';
import 'package:flutter/material.dart';
import 'package:w2k/model/UserModel.dart';
import 'package:w2k/providers/UserProvider.dart';
import 'package:w2k/screens/LoginScreen.dart';
import 'package:w2k/screens/LunchingScreen.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  AdminModel userModel = AdminModel();
  User currentUser;
  bool showSpinner = false;

  // String name;
  // String phoneNumber;
  // String email;
  // String password;

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackground,
      //backgroundColor: Colors.white,
      // body: ModalProgressHUD(
      //   inAsyncCall: showSpinner,
      //   child:
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
              height: 35.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                "REGISTER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimarycolor,
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              endIndent: 170,
              color: Colors.black54,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter your name' : null,
              controller: _nameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userModel.name = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter your phone number' : null,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userModel.phoneNumber = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter your e-mail' : null,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userModel.email = value;
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
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter your password' : null,
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userModel.password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.vpn_key_rounded),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter your password' : null,
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                userModel.password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Confirm password',
                prefixIcon: Icon(Icons.vpn_key_rounded),
              ),
            ),
            SizedBox(
              height: 9.0,
            ),
            RoundedButton(
              title: 'Register',
              colour: kPrimarycolor,
              //colour: Color.fromARGB(255,87,190,146),
              onPressed: () {
                Navigator.pushNamed(context, LunchingScreen.id);
              },
              // onPressed: () async {
              //   // setState(() {
              //   //   showSpinner = true;
              //   // });
              //   userModel.location = "banki";
              //   print(userModel.email);
              //   print(userModel.password);
              //   try {
              //     final newUser = await _auth.createUserWithEmailAndPassword(
              //         email: userModel.email, password: userModel.password);
              //     if (newUser != null) {
              //       _firestore.collection('user').add(userModel.toJson());
              //       Provider.of<UserProvider>(context, listen: false).setUser(userModel);
              //       print(userModel.name);
              //       // Provider.of<UserProvider>(context, listen: false)
              //       //     .setUser(userModel);
              //       // User user = _firestore.collection('user').get();
              //       // Provider.of<UserProvider>(context,listen: false).setUser(user);
              //       currentUser = _auth.currentUser;
              //       Navigator.pushNamed(context, LunchingScreen.id);
              //     }
              //     setState(() {
              //       showSpinner = false;
              //     });
              //   } catch (e) {
              //     print(e);
              //   }
              //   ;

              // _firestore.collection('user').add({
              //   'name': name,
              //   'phone': phoneNumber,
              //   'email': email,     //add this
              //   'password': password,
              // });
              //},
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
                        text: "Already a member ? ",
                        style: TextStyle(color: kTextColor)),
                    TextSpan(
                        text: "Log In", style: TextStyle(color: kPrimarycolor)),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
    //);
  }
}
