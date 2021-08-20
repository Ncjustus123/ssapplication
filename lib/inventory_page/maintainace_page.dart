import 'dart:io';

import 'package:driver_salary/Reusables/ui_reusable.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/model/departmentmodel.dart';
import 'package:driver_salary/model/issuemodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:random_string/random_string.dart';


class MaintainanceRequestPage extends StatefulWidget {
  @override
  _MaintainanceRequestPage createState() => _MaintainanceRequestPage();
}

class _MaintainanceRequestPage extends State<MaintainanceRequestPage> {
  bool loading = true;
  DepartmentModel departmentModel;
  IssueModel issueModel;

  String depdropdownValue;
  String issuedropdonValue;

  List<String> departmentModelList = List();
  List<String> issueModelList = List();
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  @override
  void initState() {
    super.initState();
    getDepartment();
    getIssue();
  }

  getDepartment() {
    try {
      authClient.getDepartment()
        ..then((response) {
          departmentModel = DepartmentModel.fromJson(response.body);
          departmentModelList.add("Select Department");
          for (int i = 0; i < departmentModel.object.items.length; i++) {
            departmentModelList.add(departmentModel.object.items[i].name);
            if (i == 0) {
              depdropdownValue = departmentModelList[0];
              print(depdropdownValue);
            }
          }
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

  getIssue() {
    try {
      //get Issue
      authClient.getIssue()
        ..then((response) {
          issueModel = IssueModel.fromJson(response.body);
          print(" welcome $issueModel");
          issueModelList.add("Select Issue");
          for (int i = 0; i < issueModel.object.items.length; i++) {
            issueModelList.add(issueModel.object.items[i].name);
            if (i == 0) {
              issuedropdonValue = issueModelList[0];
              print(issuedropdonValue);
            }
          }
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

  var r = randomNumeric(6);
  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Container(
      color: Colors.white,
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
    )
        : Scaffold(
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Requestpage(
                  readOnly: true,
                  title: 'Reference Number',
                  hint: ' REF-$r',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                    isExpanded: true,
                    value: depdropdownValue,
                    isDense: false,
                    onChanged: (String newValue) {
                      depdropdownValue = newValue;
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    hint: Text("Department"),
                    items: departmentModelList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    value: issuedropdonValue,
                    onChanged: (String newValue) {
                      issuedropdonValue = newValue;
                      setState(() {
                        print("new value is a $newValue");
                      });
                    },
                    hint: Text(" Select Issue"),
                    items: issueModelList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList()),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                child: TextField(
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
                  readOnly: false,
                  title: 'Unit Price:',
                  hint: ' Enter Unit',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Requestpage(
                  readOnly: false,
                  title: 'Quantity:',
                  hint: ' Enter Quantity',
                ),
              ),
              //Checkbox(value: null, onChanged: null),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Requestpage(
                  readOnly: false,
                  title: 'Total Price:',
                  hint: ' Enter Price',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                        elevation: 5,
                        child: Text('Submit'),
                        color: Colors.blue,
                        onPressed: () {}),
                    SizedBox(
                      width: 15,
                    ),
                    RaisedButton(
                        elevation: 5,
                        child: Text('Cancel'),
                        color: Colors.grey[300],
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
