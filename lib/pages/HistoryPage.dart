import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/model/DustbinModel.dart';
import 'package:w2k/providers/DustbinProvider.dart';

final _firestore = FirebaseFirestore.instance;

class HistoryPage extends StatefulWidget {
  double sum = 0;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  // double sum() {
  //   double sum = 0;
  //   for (double e in trilingList) {
  //     sum = sum + e;
  //   }
  //   return sum;
  // }

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
        color: kHomecolor,
        //color: Color.fromARGB(40,9,167,109),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/home1.jpeg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
        //   ),
        // ),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("waste_deposit_data").snapshots(),
            builder: (context, dataSnapshot) {
              if (!dataSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DustbinModel dustbinModel = DustbinModel.fromJson(
                        //dataSnapshot.data.docs[index].data()
                      dataSnapshot.data.docs[index].data());
                    return dustbinInfo(dustbinModel, context);
                  },
                  itemCount: dataSnapshot.data.docs.length,
                ),
              );
            }),
      ),
    );
  }
}

Widget dustbinInfo(DustbinModel dustbinModel, BuildContext context) {

  // HistoryPage _historyPage = HistoryPage();
  // List<double> pointSum = [];
  // double pointInDouble = double.parse(dustbinModel.points);
  // pointSum.add(pointInDouble);
  // print(pointSum);
  //
  // for(int i=0; i < pointSum.length; i++) {
  //   _historyPage.sum += pointSum[i];
  // }
  // print(_historyPage.sum);

  Provider.of<DustbinProvider>(context,listen: false).setUser(15.5);
  //print(pointSum.s);



  //Double totalPoint = pointSum

  return Column(
    children: <Widget>[
      Padding(
      padding: EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9.0),),
            color: kBackground
            //color: Colors.white70
            //color: Colors.deepOrange.shade300.withOpacity(0.4),
            //color: Color.fromARGB(163, 122, 248, 202),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Reward received',
                  style: TextStyle(color: kTextColor),
                ),
                trailing: Text(
                  dustbinModel.points,
                  //trilingList[index].toString(),
                  style: TextStyle(
                      color: kTextColor, fontSize: 25.0, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                    "${dustbinModel.weight} kg",
                    style: TextStyle(
                      color: kTextColor,
                    ),),
                isThreeLine: true,
                leading: Image.asset('assets/reward.png'),
                // leading: CircleAvatar(
                //   backgroundImage: imageArray[index],
              ),
              // Text(
              //   "${dustbinModel.weight} kg",
              //   style: TextStyle(
              //     color: Colors.black54,
              //   ),),
            ],
          ),
        ),
      ),
    ],
  );
}

// child: ListView.builder(
//   itemCount: 3,
//   scrollDirection: Axis.vertical,
//   itemBuilder: (context, index) => Container(
//     child: Column(
//       children: <Widget>[
//         ListTile(
//           title: Text('Reward received', style: TextStyle(color: Colors.white ),),
//           trailing: Text(trilingList[index].toString(),style: TextStyle(color: Colors.white, fontSize: 25.0 , fontWeight: FontWeight.w600),),
//           subtitle: Text(subtitleList[index], style: TextStyle(color: Colors.white,) ),
//           isThreeLine: true,
//           leading: Image.asset('assets/reward.png'),
//           // leading: CircleAvatar(
//           //   backgroundImage: imageArray[index],
//         ),
//
//       ],
//     ),
//   ),
// ),
