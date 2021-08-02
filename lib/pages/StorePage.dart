import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  //List shopList = [];

  @override
  void initState() {
    //fetchDatabaseList();
    super.initState();
  }

  // fetchDatabaseList() async{
  //   dynamic resultant = await DatabaseManager().getShopList();
  //
  //   if (resultant ==null) {
  //     print("Unable to retrive");
  //   } else {
  //     print('inside fetcher');
  //     setState(() {
  //       shopList = resultant;
  //       print(resultant.runtimeType);
  //     });
  //   }
  // }

  var titleList = [
    "Ganesh Grocery",
    "Ganesh Grocery",
    "Ganesh Grocery",
  ];

  var imageArray = [
    AssetImage("assets/shop1.jpeg"),
    AssetImage("assets/shop2.jpeg"),
    AssetImage("assets/shop3.jpeg"),
  ];

  var subtitleList = [
    "opens from 8 am to 10 pm",
    "opens from 8 am to 10 pm",
    "opens from 8 am to 10 pm",
  ];

  var trilingList = [
    "1.2",
    "0.6",
    "3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _buildBody(context)
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  //title: Text(shopList[index].data['name']),
                  //subtitle: Text("Opens at" + shopList[index].data['opensAt'] + "and closes at" + shopList[index].data  ['closesAt']),
                  title: Text(titleList[index]),
                  subtitle: Text(subtitleList[index]),
                  isThreeLine: true,
                  // onTap: () {
                  //   print('tapped');
                  //   return MapPage();
                  // },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image(
                      image: imageArray[index],
                    ),
                  ),
                  //  leading: CircleAvatar(
                  //    backgroundImage: imageArray[index],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}














// Widget _buildBody(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: _firestore.collection('shop').snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return Center(
//           child: CircularProgressIndicator(
//             backgroundColor: Colors.lightBlueAccent,
//           ),
//         );
//       }
//
//       return _buildList(context, snapshot.data.docs);
//     },
//   );
// }
//
// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return ListView(
//       padding: const EdgeInsets.only(top: 20.0),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList()
//   );
// }
//
// Widget _buildListItem(BuildContext context, DocumentSnapshot data, ) {
//   final record = Record.fromSnapshot(data);
//
//   print(record.name);
//
//   var imageArray = [
//     AssetImage("assets/shop1.jpeg"),
//     AssetImage("assets/shop2.jpeg"),
//     AssetImage("assets/shop3.jpeg"),
//   ];
//
//
//   return Container(
//     child: Expanded(
//       child: ListView.builder(
//         itemCount: 1,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (context, index) => Container(
//           child: Column(
//             children: <Widget>[
//               ListTile(
//                 title: Text(record.name),
//                 subtitle: Text("Opens at" + record.opensAt + "and closes at" + record.closesAt),
//                 // title: Text(titleList[index]),
//                 // subtitle: Text(subtitleList[index]),
//                 isThreeLine: true,
//                 // onTap: () {
//                 //   print('tapped');
//                 //   return MapPage();
//                 // },
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(5.0),
//                   child: Image(
//                     image: imageArray[index],
//                   ),
//                 ),
//                 //  leading: CircleAvatar(
//                 //    backgroundImage: imageArray[index],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//
//   // return Padding(
//   //   key: ValueKey(record.closesAt),
//   //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//   //   child: Container(
//   //     decoration: BoxDecoration(
//   //       border: Border.all(color: Colors.grey),
//   //       borderRadius: BorderRadius.circular(5.0),
//   //     ),
//   //     child: ListTile(
//   //       title: Column(
//   //         children: <Widget>[
//   //           Padding(
//   //             padding: const EdgeInsets.all(10.0),
//   //             child: Text(
//   //               record.closesAt,
//   //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//   //             ),
//   //           ),
//   //           Image.network(record.opensAt),
//   //           Padding(
//   //             padding: const EdgeInsets.all(10.0),
//   //             child: Column(
//   //               children: [
//   //                 Text(
//   //                   record.name,
//   //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//   //                 ),
//   //                 Text(
//   //                   record.longitude,
//   //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//   //                 ),
//   //                 Text(
//   //                   record.latitude,
//   //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   ),
//   // );
// }
//
//
// class Record {
//   final String name;
//   final String opensAt;
//   final String closesAt;
//   //final DocumentReference reference;
//
//   Record.fromMap(Map<String, dynamic> map, )
//       : assert(map['name'] != null),
//         assert(map['opensAt'] != null),
//         assert(map['closesAt'] != null),
//
//         name = map['location'],
//         opensAt = map['url'],
//         closesAt = map['store'];
//
//
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(
//     snapshot.data(),
//     //reference: snapshot.reference,
//   );
//
//   @override
//   String toString() => "Record<$name:$opensAt:$closesAt>";
// }





