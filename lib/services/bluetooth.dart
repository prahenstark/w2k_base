import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Device extends BluetoothDevice{
  String myAddress;
  String name;


  Device(this.myAddress, this.name);

}