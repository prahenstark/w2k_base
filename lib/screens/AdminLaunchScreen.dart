import 'dart:convert';
import 'dart:ui';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:w2k/components/ProfileDrawer.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/model/ImageSliderModel.dart';
import 'package:w2k/helper/helper.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:w2k/model/Listpaymodel.dart';
import 'package:w2k/model/UserModel.dart';
import 'package:w2k/pages/AdminDataUpdatePage.dart';
import 'package:w2k/pages/LaunchPage.dart';
import 'package:w2k/pages/MyMoneyPage.dart';
import 'package:w2k/pages/MapPage.dart';
import 'package:w2k/pages/HistoryPage.dart';
import 'package:w2k/pages/StorePage.dart';
import 'package:w2k/pages/AdminLaunchPage.dart';
import 'package:w2k/providers/UserProvider.dart';
import 'package:w2k/services/bluetooth.dart';

final _firestore = FirebaseFirestore.instance; //Use FirebaseFirestore instead of Firestore.
User loggedInUser;


class AdminLunchScreen extends StatefulWidget {
  static String id = 'admin_launch_screen';

  @override
  _LunchingScreen createState() => _LunchingScreen();
}

class _LunchingScreen extends State<AdminLunchScreen> {
  final _auth = FirebaseAuth.instance;


  int _currentIndex = 0;

  BluetoothConnection connection;

  //BluetoothDevice bluetoothDevice;
  Device device;

  bool get isConnected => connection != null && connection.isConnected;
  String bluetoothValueToSend;
  String bluetoothDeviceId;
  BluetoothState _bluetoothState = BluetoothState.STATE_ON;
  bool _isButtonUnavailable = false;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // bluetooth.ScanResult scanResult;
  // bluetooth.BluetoothDevice bluetoothDevice;
  // String bluetoothDeviceId;
  // List<bluetooth.BluetoothService> _services;


  ScanResult resultQr;
  List<String> dataList;
  String locationText;
  String gestureLocation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // Get current state
    // FlutterBluetoothSerial.instance.state.then((state) {
    //   setState(() {
    //     _bluetoothState = state;
    //   });
    // });
    //
    // _deviceState = 0; // neutral
    //
    // // If the bluetooth of the device is not enabled,
    // // then request permission to turn on bluetooth
    // // as the app starts up
    // BluetoothHelper.enableBluetooth(_bluetoothState);
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  //For retrieving and storing the paired devices
  //in a list.
  // Future<void> getPairedDevices() async {
  //   List<BluetoothDevice> devices = [];
  //
  //   // To get the list of paired devices
  //   try {
  //     devices = await _bluetooth.getBondedDevices();
  //   } on PlatformException {
  //     print("Error");
  //   }
  //
  //   // It is an error to call [setState] unless [mounted] is true.
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   // Store the [devices] list in the [_devicesList] for accessing
  //   // the list outside this class
  //   // setState(() {
  //   //   _devicesList = devices;
  //   // });
  // }

  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        resultQr = qrResult;
        dataList = resultQr.rawContent.toString().split(';');
        print(dataList);
        bluetoothDeviceId = dataList[1];
        //bluetoothDeviceId = resultQr.rawContent.substring(10,27).toUpperCase();
        //bluetoothDevice.id = bluetoothDeviceId;
        device = Device(bluetoothDeviceId, 'laptop');
        bluetoothValueToSend = "${Provider
            .of<UserProvider>(context)
            .user
            .email};${resultQr.rawContent}";
        print('scanned data is ${resultQr.rawContent} ');
        print('scanned MAC ID is ${bluetoothDeviceId} ');
      });
      _firestore.collection('QRcodes').add({
        'input': resultQr.rawContent,
        'macId': bluetoothDeviceId,
        'user': loggedInUser.email,
        'time': FieldValue.serverTimestamp()
      });
      // _firestore.collection('user').add({
      //   'QRcode': result.rawContent,
      // });
      print("scanned");
    } catch (e) {
      print(e);
    }
  }

  void _sendTextMessageToBluetooth(BluetoothConnection connection,
      String message) async {
    connection.output.add(utf8.encode(message + "\r\n"));
    await connection.output.allSent;

    // setState(() {
    //   _deviceState = -1; // device off
    // });
  }

  _showSingleChoiceDialog(BuildContext context, String title) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepOrangeAccent,
            content: Text(
              title,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          );
        },
      );

  // void _connect() async {
  //   setState(() {
  //     _isButtonUnavailable = true;
  //   });
  //   if (_device == null) {
  //     BluetoothHelper.show(_scaffoldKey, 'No device selected');
  //   } else {
  //     if (!isConnected) {
  //       await BluetoothConnection.toAddress(_device.address)
  //           .then((_connection) {
  //         print('Connected to the device');
  //         connection = _connection;
  //         setState(() {
  //           _connected = true;
  //         });
  //
  //         connection.input.listen(null).onDone(() {
  //           if (isDisconnecting) {
  //             print('Disconnecting locally!');
  //           } else {
  //             print('Disconnected remotely!');
  //           }
  //           if (this.mounted) {
  //             setState(() {});
  //           }
  //         });
  //       }).catchError((error) {
  //         print('Cannot connect, exception occurred');
  //         print(error);
  //       });
  //       BluetoothHelper.show(_scaffoldKey, 'Device connected');
  //
  //       setState(() => _isButtonUnavailable = false);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: pageCaller(_selectedIndex),
      ),
      bottomNavigationBar: _bottemTab(),
      //body: pageCaller(_selectedIndex),
    );
  }

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return AdminLaunchPage();
        }
        break;
      case 1:
        {
          return AdminDataUpdate();
        }
        break;
    }
  }

  Widget _appBar() {
    return new AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimarycolor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileDrawerWidget.id);
            },
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/user.jpeg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5.0, 0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Location',
                  style: TextStyle(fontSize: 10),
                ),
                Row(children: <Widget>[
                  Container(
                    //width: 50.0,
                    //color: Colors.blue,
                    child: Text(
                      'Banki',
                      //Provider.of<UserProvider>(context,listen: false).user.name,
                      //gestureLocation,
                      //Provider.of<UserProvider>(context,listen: false).user.location,
                      //userModel.location.toString(),
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.arrow_drop_down),
                    onTap: () {
                      print('gesture tapped');
                      //gestureLocation = userModel.name;
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Image.asset(
                  "assets/outline_qrscan.png",
                  color: Colors.white,
                  height: 24,
                  width: 24,
                ),
              ),
              onTap: () {},
            ),
            GestureDetector(
              onTap: () async {
                //BluetoothConnection.toAddress(bluetoothDeviceId);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Icon(Icons.notifications_active_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 13,
                ),
                child: Icon(Icons.help_outline),
              ),
            ),
          ],
        ),
      ],
      elevation: 0,
    );
  }

  Widget _bottemTab() {
    return Container(
      //color: Color.fromARGB(255,247, 252, 255),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
          ),
        ],
      ),
      child: BottomNavigationBar(
        //backgroundColor: Colors.deepOrangeAccent.withOpacity(0.4),
        elevation: 27.5,
        backgroundColor: kBackground.withOpacity(0.7),
        selectedItemColor: kPrimarycolor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.ios_share),
            label: 'Update Data',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
