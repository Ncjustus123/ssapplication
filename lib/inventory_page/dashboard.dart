import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:driver_salary/inventory_page/cancelledserviceRequest.dart';
import 'package:driver_salary/inventory_page/inventory_page.dart';
import 'package:driver_salary/inventory_page/service_page.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cancelledstockrequest.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: Drawer(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                color: Colors.purple,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Inventory',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, 140, 0),
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(5))),
              ),
              Container(
                transform: Matrix4.translationValues(0, 80, 0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        leading: Icon(FontAwesomeIcons.cube),
                        title: Text("Stock"),
                        children: [
                          Column(
                            children: [
                              ListTile(
                                  leading: Icon(Icons.navigate_next),
                                  title: Text("Request"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InventoryPage()));
                                  }),
                              ListTile(
                                leading: Icon(Icons.navigate_next),
                                title: Text(" Cancelled Request"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CancelledStock()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        leading: Icon(Icons.assignment),
                        title: Text("Service"),
                        children: [
                          Column(
                            children: [
                              ListTile(
                                  leading: Icon(Icons.navigate_next),
                                  title: Text("Request"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicePage()));
                                  }),
                              ListTile(
                                leading: Icon(Icons.navigate_next),
                                title: Text(" Cancelled Request"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CancelledServiceRequest()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Card(
                    //   elevation: 1,
                    //   clipBehavior: Clip.antiAlias,
                    //   child: ExpansionTile(
                    //     initiallyExpanded: false,
                    //     leading: Icon(FontAwesomeIcons.cube),
                    //     title: Text("Maintainace"),
                    //     children: [
                    //       Column(
                    //         children: [
                    //           ListTile(
                    //               leading: Icon(Icons.navigate_next),
                    //               title: Text("Request"),
                    //               onTap: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             MaintainancePage()));
                    //               }),
                    //           ListTile(
                    //             leading: Icon(Icons.navigate_next),
                    //             title: Text(" Cancelled Request"),
                    //             onTap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           CancelledStock()));
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text('DashBoard',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.purple,
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
            child: (Column(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Inventory",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DefaultTabController(
                        length: 3,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TabBar(
                            indicator: BubbleTabIndicator(
                                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                indicatorHeight: 35,
                                indicatorColor: Colors.white),
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Text("Total"),
                              Text("Today"),
                              Text("Yesterday"),
                            ],
                            onTap: (index) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,

                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            _buildStatCard("total request Libmot", "100", Colors.orange),
                            _buildStatCard("total req Logistics", "50", Colors.red),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            _buildStatCard("total per terminal", "150", Colors.teal),
                            _buildStatCard("total approved req", "100", Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: charts.BarChart(
                    _createSampleData(),
                    defaultRenderer: charts.BarRendererConfig(
                        cornerStrategy: const charts.ConstCornerStrategy(30)),
                  ),
                ),
              ],
            )),
          )
        ]));
  }

  Expanded _buildStatCard(String tilte, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tilte,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}

List<charts.Series<OrdinalSales, String>> _createSampleData() {
  final data = [
    new OrdinalSales('2014', 5),
    new OrdinalSales('2015', 25),
    new OrdinalSales('2016', 100),
    new OrdinalSales('2017', 75),
  ];

  return [
    new charts.Series<OrdinalSales, String>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: data,
    )
  ];
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
