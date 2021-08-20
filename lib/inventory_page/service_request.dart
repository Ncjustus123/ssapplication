import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:driver_salary/Reusables/ui_reusable.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/model/departmentmodel.dart';
import 'package:driver_salary/model/issuemodel.dart';
import 'package:driver_salary/model/servicemodel.dart';
import 'package:driver_salary/model/terminalmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:random_string/random_string.dart';
import '../main.dart';

class ServiceRequestPage extends StatefulWidget {
  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  bool loading = true;
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;
  DepartmentModel departmentModel;
  IssueModel issueModel;
  TerminalModel terminalModel;

  String depdropdownValue;
  String issuedropdonValue;
  String terminaldropdownValue;

  List<String> departmentModelList = List();
  List<String> issueModelList = List();

  final textController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController quantity = TextEditingController();

  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  @override
  void initState() {
    super.initState();
    getDepartment();
    getIssue();
    getTerminal();
    textController.addListener(_printValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textController.dispose();
    super.dispose();
  }

  _printValue() {
    print("Second text field: ${textController.text}");
  }

  getDepartment() {
    try {
      authClient.getDepartment().then((response) {
        departmentModel = DepartmentModel.fromJson(response.body);
      }).then((_) {
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

  getIssue() {
    try {
      //get Issue
      authClient.getIssue().then((response) {
        issueModel = IssueModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading1 = false;
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

  getTerminal() {
    try {
      //get all drivers
      authClient.getTerminal().then((response) {
        terminalModel = TerminalModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading2 = false;
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

  ServiceItems items;

  sendData() async {
    showLoading(
        progressColor: Colors.purple,
        indicatorColor: Colors.purple,
        backgroundColor: Colors.white,
        textColor: Colors.purple,
        indicatorType: EasyLoadingIndicatorType.fadingCircle,
        status: "Submitting.....");

    items = ServiceItems(
      departmentID: int.parse(depdropdownValue),
      issueId: int.parse(issuedropdonValue),
      description: description.text,
      note: note.text,
      quantity: int.parse(quantity.text),
      terminalID: int.parse(terminaldropdownValue),
      price: double.parse(textController.text),
      referenceNumber: referenceNumber,
    );

    print('this' + items.toJson().toString());
    Response response = await authClient.serviceRequestCreate(items.toJson());

    if (response.isSuccessful) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      buildDialog(context);
    } else
      EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Error creating request"),
    ));
  }

  String referenceNumber = 'SER-${randomNumeric(6)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 10,
        title: Text('Create request',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
      ),
      body: (loading || loading1 || loading2)
          ? Container(
        color: Colors.white,
        child: CircularProgressIndicator(),
        alignment: Alignment.center,
      )
          : Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  validator: (depdropdownValue) =>
                  depdropdownValue == null
                      ? "Fields are required"
                      : null,
                  isExpanded: true,
                  value: depdropdownValue,
                  decoration: InputDecoration(
                    labelText: "Department",
                  ),
                  isDense: false,
                  onChanged: (String newValue) {
                    depdropdownValue = newValue;
                    setState(() {
                      print("new value is $newValue");
                    });
                  },
                  items: departmentModel.object.items
                      .map((DepartmentItems department) {
                    return DropdownMenuItem<String>(
                        value: department.id.toString(),
                        child: Text(department.name));
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                    validator: (issuedropdonValue) =>
                    issuedropdonValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: issuedropdonValue,
                    onChanged: (String newValue) {
                      issuedropdonValue = newValue;
                      setState(() {
                        print("new value is a $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Issue",
                    ),
                    items:
                    issueModel.object.items.map((IssueItems issue) {
                      return DropdownMenuItem<String>(
                          value: issue.id.toString(),
                          child: Text(issue.name));
                    }).toList()),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: TextField(
                    controller: description,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Enter description of service",
                      labelText: "Description",
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: TextField(
                    controller: note,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Enter a note ",
                      labelText: "Note",
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Requestpage(
                    onchanged: (text) {
                      print(" first $text");
                    },
                    readOnly: false,
                    title: 'Unit Price:',
                    hint: ' Enter Unit Price',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Requestpage(
                    controller: quantity,
                    readOnly: false,
                    title: 'Quantity:',
                    hint: ' Enter Quantity',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField<String>(
                    validator: (terminaldropdownValue) =>
                    terminaldropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: terminaldropdownValue,
                    onChanged: (String newValue) {
                      terminaldropdownValue = newValue;
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Terminal",
                    ),
                    items: terminalModel.object.items
                        .map((TerminalItems terminalitems) {
                      return DropdownMenuItem<String>(
                          value: terminalitems.id.toString(),
                          child: Text(terminalitems.name));
                    }).toList()),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Requestpage(
                    controller: textController,
                    readOnly: false,
                    title: 'Total Price',
                    hint: ' Total Price',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          elevation: 5,
                          child: Text('Submit'),
                          color: Colors.blue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              sendData();
                            } else {
                              setState(() {
                                _autovalidate = true;
                              });
                            }
                          }),
                      SizedBox(
                        width: 15,
                      ),
                      RaisedButton(
                          elevation: 5,
                          child: Text('Cancel'),
                          color: Colors.grey[300],
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDialog(BuildContext context,) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20))), //this right here
              child: Container(
                width: 260.0,
                height: 250.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 15),
                    // dialog top
                    new Expanded(
                      child: new Container(
                        // padding: new EdgeInsets.all(10.0),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notifications_active,
                                  color: Colors.purple,
                                  size: 25,
                                ),
                              ),
                              new Text(
                                'Success',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontFamily: 'helvetica_neue_light',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // dialog centre
                    new Expanded(
                      child: Text(
                        'Your Request has been created successfully',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: RaisedButton(
                          color: Colors.purple,
                          onPressed: () {
                            // int count = 0;
                            Navigator.pop(context);
                            // Navigator.popUntil(context, (route) {
                            //   return count++ == 2;
                            // });
                            // setState(() {});
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ));
        });
  }
}