import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryPage extends StatefulWidget {

  double suM ;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  var titleList = [
    "Paid to",
    "Payment from",
    "Payment from",
  ];

  var imageArray = [
    AssetImage("assets/college.jpeg"),
    AssetImage("assets/temple.jpeg"),
    AssetImage("assets/police.jpeg"),
  ];

  var subtitleList = [
    "1.2 kg",
    "600 gm",
    "3 kg",
  ];

  List<double> trilingList = [
    1.2,
    0.6,
    3,
  ];

  double sum() {
    double sum = 0;
    for (double e in trilingList) {
      sum = sum + e;
    }
    return sum;
  }




  // @override
  // void initState() {
  //   sum();
  //   print(sum);
  //   // TODO: implement initState
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    //print(sum());
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Reward received'),
                  trailing: Text(trilingList[index].toString(),style: TextStyle(fontSize: 25.0 , fontWeight: FontWeight.w600),),
                  subtitle: Text(subtitleList[index]),
                  isThreeLine: true,
                  leading: Image.asset('assets/reward.png'),
                  // leading: CircleAvatar(
                  //   backgroundImage: imageArray[index],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}





// class Record {
//   final String location;
//   final String url;
//   final String store;
//   final String latitude;
//   final String longitude;
//   final DocumentReference reference;
//
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['location'] != null),
//         assert(map['url'] != null),
//         assert(map['store'] != null),
//         assert(map['latitude'] != null),
//         assert(map['longitude'] != null),
//         location = map['location'],
//         url = map['url'],
//         latitude = map['latitude'],
//         longitude = map['longitude'],
//         store = map['store'];
//
//
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(
//     snapshot.data(),
//     reference: snapshot.reference,
//   );
//
//   @override
//   String toString() => "Record<$location:$url:$store:$latitude:$longitude>";
// }
