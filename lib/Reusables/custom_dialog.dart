import 'package:cool_alert/cool_alert.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/provider/service_request.dart';
import 'package:driver_salary/provider/stock_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

Future buildShowDialog1(BuildContext context, InventoryItems inventoryItems,
    bool haveAccessToApproveRequest, bool haveAccessToVerifyRequest) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Consumer<ServiceRequestProvider>(
        builder: (context, serviceRequest, child) => AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Request Information",
                    style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                  ),
                ),
                SizedBox(height: 20),
                Table(
                    border: TableBorder.all(color: Colors.grey[100]),
                    children: [
                      getRow("Reference Number",
                          inventoryItems.referenceNumber),
                      getRow("Requested By", inventoryItems.requestedBy),
                      getRow("Department", inventoryItems.departmentName),
                      getRow("Description", inventoryItems.description),
                      getRow("note", inventoryItems.note),
                      getRow("Total Price",inventoryItems.price.toString()),
                      getRow(
                          "Company Type", inventoryItems.companyTypeName),
                      getRow(
                          "Verified", inventoryItems.isVerified.toString()),
                      getRow(
                          "Approved", inventoryItems.isApproved.toString()),
                      getRow("Cancelled",
                          inventoryItems.isCancelled.toString()),
                    ]),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (!haveAccessToApproveRequest ||
                        inventoryItems.isApproved ||
                        !inventoryItems.isVerified)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.green,
                        onPressed: () {
                          var id = inventoryItems.id;
                          serviceRequest.actionCall(inventoryItems, id,
                              method.approved, context);
                        },
                        child: Text(
                          "Approve",
                          style: TextStyle(color: Colors.white),
                        )),
                    (!haveAccessToVerifyRequest ||
                        inventoryItems.isVerified)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.blue,
                        onPressed: () {
                          var id = inventoryItems.id;
                          serviceRequest.actionCall(inventoryItems, id,
                              method.verify, context);
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        )),
                    (!haveAccessToApproveRequest ||
                        inventoryItems.isApproved)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.red,
                        onPressed: () {
                          var id = inventoryItems.id;
                          serviceRequest.actionCall(inventoryItems, id,
                              method.cancel, context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210, bottom: 10),
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
      ));
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

Future buildShowDialog(
    BuildContext context,
    InventoryItems inventoryItems,
    bool haveAccessToApproveRequest,
    bool haveAccessToVerifyRequest,
    bool haveAccessToissueRequest) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Consumer<StockRequestProvider>(
        builder: (context, stock, child) => AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Request Information",
                    style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                  ),
                ),
                SizedBox(height: 20),
                Table(
                    border: TableBorder.all(color: Colors.grey[100]),
                    children: [
                      getRow("Reference Number",
                          inventoryItems.referenceNumber),
                      getRow("Item Name", inventoryItems.itemName),
                      getRow("Requested By", inventoryItems.requestedBy),
                      getRow("Department", inventoryItems.departmentName),
                      getRow(
                          "Quantity", inventoryItems.quantity.toString()),
                      getRow("Mechanic", inventoryItems.mechanicName),
                      getRow(
                          "vehicleNumber", inventoryItems.vehicleRegName),
                      getRow("Drivername", inventoryItems.driverName),
                      getRow(
                          "Company Name", inventoryItems.companyTypeName),
                      getRow("Note", inventoryItems.note),
                      getRow(
                          "Verified", inventoryItems.isVerified.toString()),
                      getRow(
                          "Approved", inventoryItems.isApproved.toString()),
                      getRow("Issued", inventoryItems.isIssued.toString()),
                    ]),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (!haveAccessToApproveRequest ||
                        inventoryItems.isApproved ||
                        !inventoryItems.isVerified)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.green,
                        onPressed: () {
                          var id = inventoryItems.id;
                          stock.actionCall(inventoryItems, id,
                              methods.approved, context);
                        },
                        child: Text(
                          "Approve",
                          style: TextStyle(color: Colors.white),
                        )),
                    (!haveAccessToVerifyRequest ||
                        inventoryItems.isVerified)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.blue,
                        onPressed: () {
                          var id = inventoryItems.id;
                          stock.actionCall(inventoryItems, id,
                              methods.verify, context);
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        )),
                    (!haveAccessToApproveRequest ||
                        inventoryItems.isApproved)
                        ? SizedBox()
                        : FlatButton(
                        height: 50.0,
                        color: Colors.red,
                        onPressed: () {
                          var id = inventoryItems.id;
                          stock.actionCall(inventoryItems, id,
                              methods.cancel, context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210, bottom: 10),
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
      ));
}
