import 'dart:io';

import 'package:driver_salary/model/cancelledstock.dart';
import 'package:flutter/material.dart';
import 'package:driver_salary/Functions/CustomWidget.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../authentication_service.dart';


class CancelledStock extends StatefulWidget {
  @override
  _CancelledStockState createState() => _CancelledStockState();
}

class _CancelledStockState extends State<CancelledStock> {
  bool loading = true;
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  @override
  void initState() {
    super.initState();
    getcancelledStockreqeust();
  }

  CancelledStockModel cancelledStock;

  getcancelledStockreqeust() {
    try {
      //get all mechanic
      authClient.getcancelledStockreqeust()
        ..then((response) {
          cancelledStock = CancelledStockModel.fromJson(response.body);
          print(
              "vgfgfg ${DateTime.parse(cancelledStock.object.items[0].requestDate)}");
        })
        ..then((_) {
          setState(() {
            loading = false;
          });
        });
    } on SocketException {
      //TODO: internet issues
      return null;
    } on FormatException {
      //TODO: not what's expected sent
      return null;
    } catch (e) {
      //other type of errors
      print("error occured $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Container(
      color: Colors.white,
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Cancelled Request"),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cancelledStock.object.items.length,
              itemBuilder: (context, i) {
                return SingleChildScrollView(
                  child: InkWell(
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Text(cancelledStock
                            .object.items[i].referenceNumber),
                        title: Text(
                            cancelledStock.object.items[i].itemName),
                        trailing: Text(cancelledStock
                            .object.items[i].departmentName),
                      ),
                    ),
                    onTap: () async {
                      await buildShowDialog(context, i);
                    },
                  ),
                );
              }),

        ),
      ),
    );
  }

  Future buildShowDialog(BuildContext context, int i) {
    return showDialog(
        context: context,
        builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 90),
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Contact Information",
                      style:
                      TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),
                    SizedBox(height: 20),
                    Table(
                        border: TableBorder.all(color: Colors.grey[100]),
                        children: [
                          getRow(
                              "Date Requested",
                              DateFormat.yMMMd().format(DateTime.parse(
                                  cancelledStock
                                      .object.items[i].requestDate))),
                          getRow(
                              "Reference Number",
                              cancelledStock
                                  .object.items[i].referenceNumber),
                          getRow("Item Name",
                              cancelledStock.object.items[i].itemName),
                          getRow("Requested By",
                              cancelledStock.object.items[i].requestedBy),
                          getRow(
                              "Department",
                              cancelledStock
                                  .object.items[i].departmentName),
                          getRow(
                              "Quantity",
                              cancelledStock.object.items[i].quantity
                                  .toString()),
                        ]),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 250, bottom: 10),
                      child: FloatingActionButton(
                          child: Icon(Icons.clear),
                          backgroundColor: Colors.purple,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

TableRow getRow(String label, String value,
    [bool isTotal = false, bool isFixed = false]) {
  return TableRow(decoration: BoxDecoration(), children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: Text(
        label ?? "Not set",
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value ?? "Not set",
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    )
  ]);
}
