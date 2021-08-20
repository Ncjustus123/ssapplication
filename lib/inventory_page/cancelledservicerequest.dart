import 'dart:io';

import 'package:driver_salary/model/cancelledservicemodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../authentication_service.dart';

class CancelledServiceRequest extends StatefulWidget {
  @override
  _CancelledServiceRequestState createState() =>
      _CancelledServiceRequestState();
}

class _CancelledServiceRequestState extends State<CancelledServiceRequest> {
  bool loading = true;
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  @override
  void initState() {
    super.initState();
    getcancelledServiceRequest();
  }

  CancelledServiceReq cancelledServiceReq;

  getcancelledServiceRequest() {
    try {
      //get all mechanic
      authClient.getcancelledServiceRequest()
        ..then((response) {
          cancelledServiceReq = CancelledServiceReq.fromJson(response.body);
          print(
              "vgfgfg ${DateTime.parse(cancelledServiceReq.object.items[0].requestDate)}");
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
              itemCount: cancelledServiceReq.object.items.length,
              itemBuilder: (context, i) {
                return SingleChildScrollView(
                  child: InkWell(
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Text(cancelledServiceReq
                            .object.items[i].referenceNumber),
                        title: Text(cancelledServiceReq
                            .object.items[i].quantity.toString()),
                        trailing: Text(cancelledServiceReq
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
                                  cancelledServiceReq
                                      .object.items[i].requestDate))),
                          getRow(
                              "Reference Number",
                              cancelledServiceReq
                                  .object.items[i].referenceNumber),
                          getRow("Item Name",
                              cancelledServiceReq.object.items[i].itemName),
                          getRow(
                              "Requested By",
                              cancelledServiceReq
                                  .object.items[i].requestedBy),
                          getRow(
                              "Department",
                              cancelledServiceReq
                                  .object.items[i].departmentName),
                          getRow(
                              "Quantity",
                              cancelledServiceReq.object.items[i].quantity
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
