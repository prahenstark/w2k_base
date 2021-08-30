import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/constants.dart';
import 'package:w2k/model/ShopModel.dart';

final _firestore = FirebaseFirestore.instance;

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
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
            stream: _firestore.collection("shops").snapshots(),
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
                    ShopModel shopModel = ShopModel.fromJson(
                        dataSnapshot.data.docs[index].data());
                    return shopInfo(shopModel, context);
                  },
                  itemCount: dataSnapshot.data.docs.length,
                ),
              );
            }),
      ),
    );
  }
}

Widget shopInfo(ShopModel model, BuildContext context) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white70
          //color: Colors.deepOrange.shade300.withOpacity(0.55),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                height: 130.0,
                width: 175.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      model.photoUrl,
                      // width: 100.0,
                      // height: 60.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Text(
                    model.name,
                    style: TextStyle(color: kTextColor, fontSize: 20.0),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: 55.0,
                    child: Text(
                      model.longDescription,
                      style: TextStyle(color: kTextColor, fontSize: 13.0),
                    ),
                  ),
                  Row(
                    children: [
                      //Icon(Icons.timer, color: Color(0xff757575),),
                      Icon(Icons.timer, color: kTextColor, size: 20.0),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${model.opnesAt} to",
                        style: TextStyle(color: kTextColor, fontSize: 13.0),
                      ),
                      Text(
                        model.closesAt,
                        style: TextStyle(color: kTextColor, fontSize: 13.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //Icon(Icons.location_on, color: Color(0xff757575),),
                      Icon(Icons.location_on, color: kTextColor, size: 20.0),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${model.location} to",
                        style: TextStyle(color: kTextColor, fontSize: 13.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
