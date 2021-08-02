import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:w2k/services/location.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}



class MapPageState extends State<MapPage> {

  double latitude;
  double longitude;



  // Future<void> getLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;
  //   return position;
  // }

  Future <void> getLocation() async{
    try {
      //print("Inside try block.");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,forceAndroidLocationManager: true) ;
      //print( "trying to print type ${position.runtimeType}");
      latitude = position.latitude;
      longitude = position.longitude;

      setState(() {});

      //return position;

      print('latitude is $latitude longitude is $longitude');
    } catch(e) {
      print("Error is "+e);
    }

  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    getLocation();
    print('init');
    super.initState();
  }

  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildGoogleMap(context, latitude,longitude),
            _zoomminusfunction(),
            _zoomplusfunction(),
            _buildContainer(),
          ],
        ),
      ),
    );
  }

  Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus,color:Colors.deepOrange),
          onPressed: () {
            zoomVal--;
            _minus( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {

    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus,color:Colors.deepOrange),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  'assets/college.jpeg',
                  20.376118,85.5209641,"Banki Auto. College"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  'assets/temple.jpeg',
                  20.3773854,85.5277941,"Maa Charchika Temple"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  'assets/police.jpeg',
                  20.3791874,85.5302703,"Banki Police Station"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_image),
                        //image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context , double latitude, double longitude) {

    //double latitude = 20.3766;
    //double longitude = 85.5290;
    print(latitude);

    if(latitude==null || longitude==null){
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(latitude, longitude), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          collegeMarker,templeMarker,policeMarker
        },
      ),
    );
  }



  // Widget _buildGoogleMap(BuildContext context) {
  //
  //   //double latitude = 20.3766;
  //   //double longitude = 85.5290;
  //
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     child: GoogleMap(
  //       mapType: MapType.normal,
  //       initialCameraPosition: CameraPosition(target: LatLng(20.3766, 85.5290), zoom: 12),
  //       onMapCreated: (GoogleMapController controller) {
  //         _controller.complete(controller);
  //       },
  //       markers: {
  //         collegeMarker,templeMarker,policeMarker
  //       },
  //     ),
  //   );
  // }


  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}


Marker collegeMarker = Marker(
  markerId: MarkerId('college'),
  position: LatLng(20.376118,85.5209641),
  infoWindow: InfoWindow(title: 'College'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
Marker templeMarker = Marker(
  markerId: MarkerId('temple'),
  position: LatLng(20.3773854,85.5277941),
  infoWindow: InfoWindow(title: 'Temple'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
Marker policeMarker = Marker(
  markerId: MarkerId('police'),
  position: LatLng(20.3791874,85.5302703),
  infoWindow: InfoWindow(title: 'Police'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);
















// import 'package:flutter/material.dart';
//
// class AppsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text(
//           "Map",
//           style: TextStyle(fontSize: 30),
//         ),
//       ),
//     );
//   }
// }
