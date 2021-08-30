import 'package:flutter/material.dart';

//const kBackground = Color.fromARGB(255,179,255,160);
const kBackground = Colors.white;
const kHomecolor = Color.fromARGB(40,9,167,109);
//const kHomecolor = Color.fromARGB(255,247,252,255);
const kPrimarycolor = Color.fromARGB(255,9,167,109);
//const kPrimarycolor = Color.fromARGB(255, 10, 95, 8);
const kTextColor = Colors.black54;

const kSendButtonTextStyle = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.deepOrange, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  prefixIcon: Icon(Icons.help),
  hintText: '',
  hoverColor: Colors.white,
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kPrimarycolor, width: 1.0),
    //BorderSide(color: Color.fromARGB(255, 2, 144, 93), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kPrimarycolor, width: 1.0),
    //BorderSide(color: Color.fromARGB(255, 2, 144, 93), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);