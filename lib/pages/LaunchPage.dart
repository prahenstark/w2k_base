import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:w2k/constants.dart';

class LaunchPage extends StatefulWidget {
  LaunchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];


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
        // child: StaggeredGridView.count(
        //   crossAxisCount: 4,
        //   crossAxisSpacing: 12.0,
        //   mainAxisSpacing: 12.0,
        //   children: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         // width: 300.0,
        //         // height: 400.0,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //           color: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //           //color: Colors.deepOrange.shade300.withOpacity(0.55),
        //         ),
        //         child: SfCartesianChart(
        //             borderWidth: 3,
        //             enableAxisAnimation: true,
        //             palette: <Color>[Colors.white, Colors.yellow],
        //             // tooltipBehavior: TooltipBehavior(
        //             //     enable: true,
        //             // color: Colors.white),
        //             title: ChartTitle(
        //                 text: 'Usage Growth',
        //                 textStyle: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 18.0,
        //                     fontWeight: FontWeight.w600)),
        //             // Initialize category axis
        //             primaryXAxis: CategoryAxis(),
        //             series: <LineSeries<SalesData, String>>[
        //               LineSeries<SalesData, String>(
        //                   markerSettings: MarkerSettings(
        //                     isVisible: true,
        //                     borderColor: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //                   ),
        //                   // Bind data source
        //                   dataSource: <SalesData>[
        //                     SalesData('Jan', 35),
        //                     SalesData('Feb', 28),
        //                     SalesData('Mar', 34),
        //                     SalesData('Apr', 32),
        //                     SalesData('May', 40)
        //                   ],
        //                   xValueMapper: (SalesData sales, _) => sales.year,
        //                   yValueMapper: (SalesData sales, _) => sales.sales)
        //             ]),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         child: SfCircularChart(
        //           title: ChartTitle(text: "Chart"),
        //             series: <CircularSeries<ChartData, String>>[
        //               // Initialize line series
        //               PieSeries<ChartData, String>(
        //                   dataSource: [
        //                     // Bind data source
        //                     ChartData('David', 25 , Colors.amber),
        //                     ChartData('Steve', 38, Colors.indigo),
        //                     ChartData('Jack', 34 , Colors.lime),
        //                     ChartData('Others', 52, Colors.orange)
        //                   ],
        //                   xValueMapper: (ChartData sales, _) => sales.x,
        //                   yValueMapper: (ChartData sales, _) => sales.y,
        //                   //strokeColor: (ChartData sales, _) => sales.color,
        //                   // Render the data label
        //                   dataLabelSettings:DataLabelSettings(isVisible : true)
        //               )
        //             ]
        //         ),
        //         // width: 300.0,
        //         // height: 400.0,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //           color: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //           //color: Colors.deepOrange.shade300.withOpacity(0.55),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 8.0),
        //       child: Container(
        //         // width: 300.0,
        //         // height: 400.0,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //           color: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //           //color: Colors.deepOrange.shade300.withOpacity(0.55),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             SizedBox(
        //               height: 30.0,
        //             ),
        //             Text(
        //               'Total user',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 25,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               height: 5.0,
        //             ),
        //             Text(
        //               '220k +',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 30,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 8.0),
        //       child: Container(
        //         // width: 300.0,
        //         // height: 400.0,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //           color: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //           //color: Colors.deepOrange.shade300.withOpacity(0.55),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             SizedBox(
        //               height: 30.0,
        //             ),
        //             Text(
        //               'Total garbage dumped',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 17,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               height: 5.0,
        //             ),
        //             Text(
        //               '1.5M + kgs',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 30,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     // Padding(
        //     //   padding: const EdgeInsets.all(8.0),
        //     //   child: Container(
        //     //     // width: 300.0,
        //     //     // height: 400.0,
        //     //     decoration: BoxDecoration(
        //     //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //     //       color: Color.fromARGB(255, 9, 167, 109).withOpacity(0.5),
        //     //       //color: Colors.deepOrange.shade300.withOpacity(0.55),
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        //   staggeredTiles: [
        //     StaggeredTile.extent(4, 250.0),
        //     StaggeredTile.extent(2, 250.0),
        //     StaggeredTile.extent(2, 120.0),
        //     StaggeredTile.extent(2, 120.0),
        //     StaggeredTile.extent(4, 250.0),
        //   ],
        // ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}