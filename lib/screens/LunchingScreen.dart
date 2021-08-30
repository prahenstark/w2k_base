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


class LunchingScreen extends StatefulWidget {
  static String id = 'launching_screen';

  @override
  _LunchingScreen createState() => _LunchingScreen();
}

class _LunchingScreen extends State<LunchingScreen> {
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
        bluetoothValueToSend = "${Provider.of<UserProvider>(context).user.email};${resultQr.rawContent}";
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

  void _sendTextMessageToBluetooth(
      BluetoothConnection connection, String message) async {
    connection.output.add(utf8.encode(message + "\r\n"));
    await connection.output.allSent;

    // setState(() {
    //   _deviceState = -1; // device off
    // });
  }

  _showSingleChoiceDialog(BuildContext context, String title) => showDialog(
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
      //extendBodyBehindAppBar: true,
      //extendBody: true,
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/home1.jpeg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
        //   ),
        // ),
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
          //return LaunchBody();
          return LaunchPage();
        }
        break;
      case 1:
        {
          return StorePage();
        }
        break;
      case 2:
        {
          return MapPage();
        }
        break;
      case 3:
        {
          return MyMoneyPage();
        }
        break;
      case 4:
        {
          return HistoryPage();
        }
        break;
    }
  }

  Widget _appBar() {
    return new AppBar(
      automaticallyImplyLeading: false,
      //backgroundColor: Colors.deepOrangeAccent.withOpacity(0.3),
      backgroundColor: kPrimarycolor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap:() {
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
        //   Container(
        //     width: 230.0,
        //     //color: Colors.blue,
        //     //child:
        //   //),
        // //),
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
              onTap: () async {
                await _scanQR();
                print('scanner tapped');
                _showSingleChoiceDialog(
                    context, "Connecting to $bluetoothDeviceId Mac Id");
                try {
                  setState(() {});
                  connection =
                      await BluetoothConnection.toAddress(device.myAddress);
                  print('Connected to the device');
                  //print(connec);
                  _sendTextMessageToBluetooth(connection, bluetoothValueToSend);
                  print(bluetoothValueToSend);
                  print('Coneected to $bluetoothDeviceId');
                  _showSingleChoiceDialog(context, "Message sent.");
                } catch (exception) {
                  print('Cannot connect, exception is $exception');
                  _showSingleChoiceDialog(
                      context, 'Sending Failed! Can not connect ');
                  print(bluetoothDeviceId);
                }
              },
            ),
            GestureDetector(
              onTap: () async {
                //BluetoothConnection.toAddress(bluetoothDeviceId);
              },
              // onTap: () async{
              //   try {
              //     await bluetoothDevice.connect();
              //   } catch (e) {
              //     if (e.code != 'already_connected') {
              //       throw e;
              //     }
              //   } finally {
              //     _services = await bluetoothDevice.discoverServices();
              //   }
              //   print(bluetoothDevice.id.toString());
              // try {
              //   await bluetoothDevice.connect();
              //   print(bluetoothDevice.id);
              // } catch(e)
              // {
              //   print(e);
              //   print(bluetoothDevice.id);
              // }
              //},
              child: Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Icon(Icons.notifications_active_rounded),
                //child: Icon(Icons.bluetooth),
                // child: Image.asset(
                //   "assets/notifications.png",
                //   color: Colors.white,
                //   height: 24,
                //   width: 24,
                // ),
              ),
            ),
            GestureDetector(
              onTap: () {
                try {
                  if (isConnected == true) {
                    _sendTextMessageToBluetooth(connection, "Close_lid");
                    _showSingleChoiceDialog(context, "Close Message sent.");
                    BluetoothHelper.disableBluetooth(_bluetoothState);
                  } else {
                    _showSingleChoiceDialog(
                        context, "Bluetooth not connected.");
                  }
                } catch (e) {
                  _showSingleChoiceDialog(
                      context, "Close Message sending Failed.");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 13,
                ),
                child: Icon(Icons.power_settings_new_rounded),
                // child: Image.asset(
                //   "assets/outline_help.png",
                //   color: Colors.white,
                //   height: 24,
                //   width: 24,
                // ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Stores',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'My Wallet',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }

//   Widget _bodyItem() {
//     return new CustomScrollView(
//       slivers: <Widget>[
//         SliverToBoxAdapter(
//           child: Container(
//             color: Colors.amber[50],
//             child: Padding(
//               padding: const EdgeInsets.only(left: 13, top: 13, bottom: 8),
//               child: Text(
//                 'Make the most of your Flutter Devs account',
//                 style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 95,
//                 color: Colors.amber[50],
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 1),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _getListpayList().length,
//                   itemBuilder: (context, index) {
//                     return Listpay(_getListpayList()[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Divider(
//             color: Colors.grey[400],
//             height: 1,
//           ),
//         ),
//         // SliverToBoxAdapter(
//         //     child: Stack(
//         //       children: <Widget>[
//         //         Container(
//         //           height: MediaQuery.of(context).size.width/3.0,
//         //           width: MediaQuery.of(context).size.width,
//         //           child: Container(
//         //             child: Padding(
//         //               padding: const EdgeInsets.only(top: 8, bottom: 13),
//         //               child: CarouselSlider(
//         //                 aspectRatio: 2,
//         //                 viewportFraction: 1.0,
//         //                 initialPage: 0,
//         //                 autoPlayInterval: Duration(seconds: 2),
//         //                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//         //                 pauseAutoPlayOnTouch: Duration(seconds: 2),
//         //                 enlargeCenterPage: true,
//         //                 autoPlay: true,
//         //                 onPageChanged: (index) {
//         //                   setState(() {
//         //                     _currentIndex = index;
//         //                     print(_currentIndex);
//         //                   });
//         //                 },
//         //                 items: CarouselSliderList(_getImageSliderList()),
//         //               ),
//         //             ),
//         //           ),
//         //         ),
//         //         Positioned(
//         //           bottom: 5.0,
//         //           right: 0.0,
//         //           left: 0.0,
//         //           child: Container(
//         //             child: new Row(
//         //               crossAxisAlignment: CrossAxisAlignment.end,
//         //               mainAxisAlignment: MainAxisAlignment.center,
//         //               children: List.generate(2, (int index) {
//         //                 return dots(_currentIndex, index);
//         //               }),
//         //             ),
//         //           ),
//         //         ),
//         //       ],
//         //     )),
//         SliverToBoxAdapter(
//           child: Container(
//             child: Text(
//               'Money Transfers',
//               style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//             ),
//             padding: EdgeInsets.only(left: 15, top: 10, bottom: 13),
//           ),
//         ),
//         SliverToBoxAdapter(
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: Container(
//                     height: 85,
//                     child: GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 1),
//                         scrollDirection: Axis.horizontal,
//                         shrinkWrap: true,
//                         itemCount: _getMoneyTransferList().length,
//                         itemBuilder: (context, index) {
//                           return MoneyTransfer(_getMoneyTransferList()[index]);
//                         }),
//                   ),
//                 ),
//               ],
//             )),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
//             child: Divider(
//               color: Colors.grey[700],
//               height: 1,
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 9,
//               top: 15,
//             ),
//             child: Container(
//               height: 90,
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 1),
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: _getSentMoneyList().length,
//                   itemBuilder: (context, index) {
//                     return SentMoney(_getSentMoneyList()[index]);
//                   }),
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Container(
//             color: Colors.grey[100],
//             height: 120,
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/banking.png",
// //                          color: Colors.pink[700],
//                         width: 40,
//                         height: 40,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 2),
//                         child: Text(
//                           'View All\nOffers',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Image.asset("assets/suggestions_strip.png"),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/ic_menu_invite.png",
//                         color: Colors.orange[700],
//                         width: 43,
//                         height: 43,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 2),
//                         child: Text(
//                           'View My\nRewards',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Image.asset("assets/suggestions_strip.png"),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Image.asset(
//                         "assets/ic_menu_invite.png",
// //                          color: Colors.deepPurple[700],
//                         width: 43,
//                         height: 43,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 2),
//                         child: Text(
//                           'Refer & Earn\nUp to ₹1000',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Container(
//             child: Text(
//               'Recharge and Pay Bills',
//               style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//             ),
//             padding: EdgeInsets.only(left: 15, top: 15),
//           ),
//         ),
//         SliverGrid(
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 110.0,
//             mainAxisSpacing: 0.5,
//             crossAxisSpacing: 0.5,
//             childAspectRatio: 1,
//           ),
//           delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//               return GridItem(_getGridItemList()[index]);
//             },
//             childCount: _getGridItemList().length,
//           ),
//         ),
//       ],
//     );
//   }

  List<Listpaymodel> _getListpayList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel(
        "assets/ic_radiofocused.png", "Bank Account Added", null));
    list.add(new Listpaymodel(
        "assets/ic_radiofocused.png", "Wallet\nActivated", null));
    list.add(new Listpaymodel("assets/newgiftcard.png", "Add\nNew Card", null));

    list.add(new Listpaymodel("assets/request_money.png", "Add\nPhoto", null));
    list.add(new Listpaymodel("assets/request_money.png", "Pay", null));
    return list;
  }

  List<Listpaymodel> _getMoneyTransferList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel("assets/request_money.png", "To Contact", null));
    list.add(new Listpaymodel(
        "assets/ic_menu_balance_selected.png", "To Account", null));
    list.add(new Listpaymodel("assets/request_money.png", "To Self", null));
    list.add(
        new Listpaymodel("assets/request_money.png", "Bank Balance", null));
    list.add(new Listpaymodel("assets/request_money.png", "To Contact", null));
    list.add(new Listpaymodel("assets/request_money.png", "To Contact", null));
    list.add(new Listpaymodel("assets/request_money.png", "To Contact", null));
    return list;
  }

  List<Listpaymodel> _getSentMoneyList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Shreyansh", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", " Self-0471", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "veenu", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Arunendra", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Arpit", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Rahul", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Aditya", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "Mayank", null));
    list.add(new Listpaymodel(
        "assets/placeholder_contact_provider.png", "ARRREEF", null));
    return list;
  }

  List<Listpaymodel> _getGridItemList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel("assets/recharge.png", "Recharge", null));
    list.add(new Listpaymodel("assets/dth.png", "DTH", null));
    list.add(new Listpaymodel("assets/electricity.png", "Electricity", null));
    list.add(new Listpaymodel("assets/creditcard.png", "Credit Card", null));
    list.add(new Listpaymodel("assets/postpaid.png", "Postpaid", null));
    list.add(new Listpaymodel("assets/landline.png", "Landline", null));
    list.add(new Listpaymodel("assets/broadband.png", "Broadband", null));
    list.add(new Listpaymodel("assets/gas.png", "Gas", null));
    list.add(new Listpaymodel("assets/water.png", "Water", null));
    list.add(new Listpaymodel("assets/datacard.png", "Datacard", null));
    list.add(new Listpaymodel("assets/insurance.png", "Insurance", null));
    list.add(new Listpaymodel("assets/muncipaltax.png", "Muncipal Tax", null));
    list.add(new Listpaymodel("assets/googleplay.png", "Google Play", null));
    list.add(new Listpaymodel("assets/giftcardd.png", "Buy Gift\nCards", null));

    return list;
  }

  List<ImageSliderModel> _getImageSliderList() {
    List<ImageSliderModel> list = new List();
    list.add(new ImageSliderModel("assets/ghghgh.jpg"));
    list.add(new ImageSliderModel("assets/ghghgh.jpg"));

    return list;
  }

  CarouselSliderList(List<ImageSliderModel> getImageSliderList) {
    return getImageSliderList.map((i) {
      return Builder(builder: (BuildContext context) {
        return imageSliderItem(i);
      });
    }).toList();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget dots(int current, index) {
    if (current != index) {
      return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor(index),
          ));
    } else {
      return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: dotColor(index)));
    }
  }

  Widget imageSliderItem(ImageSliderModel i) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: MediaQuery.of(context).size.width / 1.05,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            i.path,
            fit: BoxFit.fill,

//            width: MediaQuery.of(context).size.width/4,
//            height: MediaQuery.of(context).size.height,
          ),
        ));
  }

  Color dotColor(int index) {
    return _currentIndex == index ? Colors.grey : Colors.black;
  }
}

class Listpay extends StatelessWidget {
  Listpaymodel listpaymodel;

  Listpay(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 40,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class MoneyTransfer extends StatelessWidget {
  Listpaymodel listpaymodel;

  MoneyTransfer(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 46,
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class SentMoney extends StatelessWidget {
  Listpaymodel listpaymodel;

  SentMoney(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 46,
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  Listpaymodel listpaymodel;

  GridItem(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            listpaymodel.imagepath,
            width: 30,
            height: 30,
            color: listpaymodel.color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              listpaymodel.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class LunchingScreen extends StatelessWidget {
//
//   static String id = 'launching_screen';
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text("Hello world"),
//         ),
//       ),
//     );
//   }
// }
