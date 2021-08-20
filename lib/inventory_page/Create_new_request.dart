import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:driver_salary/main.dart';

import 'package:driver_salary/inventory_page/inventory_page.dart';
import 'package:driver_salary/model/allinventorymodel.dart';
import 'package:driver_salary/model/companyTypeModel.dart';
import 'package:driver_salary/model/departmentmodel.dart';
import 'package:driver_salary/model/driverModel.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/model/issuemodel.dart';
import 'package:driver_salary/model/mechanicmodel.dart';
import 'package:driver_salary/model/terminalmodel.dart';
import 'package:driver_salary/model/vehiclemodel.dart';
import 'package:driver_salary/model/warehousebinbyidmodel.dart';
import 'package:driver_salary/model/warehousemodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:driver_salary/authentication_service.dart';
import '../authentication_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;


class CreateRequest extends StatefulWidget {
  final populate;

  CreateRequest({this.populate});
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  bool loading = true;
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;
  bool loading4 = true;
  bool loading5 = true;
  bool loading6 = true;
  bool loading7 = true;
  bool loading8 = true;
  AllInventory allInventory;
  VehiclesModel vehicleModel;
  DepartmentModel departmentModel;
  WarehouseModel warehouseModel;
  IssueModel issueModel;
  WarehouseModelBinById warehouseBinModel;
  MechanicModel mechanicModel;
  DriverModel driverModel;
  TerminalModel terminalModel;
  CompanyTypeModel companyTypeModel;

  String dropdownValue;
  String vehicledropdownValue;
  String depdropdownValue;
  String waredropdownValue;
  String issuedropdonValue;
  String warebindropdownValue;
  String mechdropdownValue;
  String drivdropdownValue;
  String terminaldropdownValue;
  String creditTypeValue;
  String companytypevalue;
  int quantityInStock = 0;

  TextEditingController itemCond = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController note = TextEditingController();

  bool warehouseSelected = false;
  bool showQuantity = false;

  Map singleRequestItem = {
    "itemCon": '',
  };

  List creditType = [
    'Select type',
    'Credit',
    'Debit',
  ];

  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  @override
  void initState() {
    super.initState();
    getTerminal();
    getAllInventoryitemname();
    getVehicles();
    getDepartment();
    getWarehouse();
    getIssue();
    getMechanic();
    getDrivers();
    companyTypes();
  }

  getAllInventoryitemname() async {
    try {
      //get all inventory
      await authClient.getAllInventoryitemname().then((response) {
        allInventory = AllInventory.fromJson(response.body);
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

  getVehicles() {
    try {
      authClient.getVehicles().then((response) {
        vehicleModel = VehiclesModel.fromJson(response.body);
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

  getDepartment() {
    try {
      authClient.getDepartment().then((response) {
        departmentModel = DepartmentModel.fromJson(response.body);
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

  getWarehouse() {
    try {
      authClient.getWarehouse().then((response) {
        warehouseModel = WarehouseModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading3 = false;
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
          loading4 = false;
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

  void getWarehousebin(String warehouseId) async {
    Response response = await authClient.getWarehousebin(warehouseId);
    warehouseBinModel = WarehouseModelBinById.fromJson(response.body);

    setState(() {
      warehouseSelected = true;
    });
  }

  getMechanic() {
    try {
      //get all mechanic
      authClient.getMechanic().then((response) {
        mechanicModel = MechanicModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading5 = false;
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

  getDrivers() async {
    try {
      //get all drivers
      await authClient.getDrivers().then((response) {
        driverModel = DriverModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading6 = false;
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
          loading7 = false;
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

  companyTypes() {
    try {
      //get all drivers
      authClient.companyTypes().then((response) {
        companyTypeModel = CompanyTypeModel.fromJson(response.body);
      }).then((_) {
        setState(() {
          loading8 = false;
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

  InventoryItems items;

  void sendData() async {
    showLoading(
        progressColor: Colors.purple,
        indicatorColor: Colors.purple,
        backgroundColor: Colors.white,
        textColor: Colors.purple,
        indicatorType: EasyLoadingIndicatorType.fadingCircle,
        status: "Submitting.....");
    VehicleItems i = vehicleModel.object.items.singleWhere(
            (items) => items.registrationNumber == vehicledropdownValue);
    int vehicleId = i.id;

    items = InventoryItems(
      itemID: int.parse(dropdownValue),
      vehicleRegID: vehicleId,
      departmentID: int.parse(depdropdownValue),
      issueId: int.parse(issuedropdonValue),
      warehouseID: int.parse(waredropdownValue),
      warehouseBinID: int.parse(warebindropdownValue),
      driverID: int.parse(drivdropdownValue),
      quantity: int.parse(quantity.text),
      creditType: creditTypeValue,
      note: note.text,
      referenceNumber: referenceNumber,
      mechanicID: int.parse(mechdropdownValue),
      terminalID: int.parse(terminaldropdownValue),
      companyTypeName: companytypevalue,
    );
    print('this' + items.toJson().toString());
    Response response = await authClient.requestCreate(items.toJson());

    if (response.isSuccessful) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      buildDialog(context);
    } else
      EasyLoading.dismiss();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Error creating request"),
    ));
  }

  String referenceNumber = 'REF-${randomNumeric(6)}';

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
      body: (loading ||
          loading1 ||
          loading2 ||
          loading3 ||
          loading4 ||
          loading5 ||
          loading6 ||
          loading7 ||
          loading8)
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
                    validator: (dropdownValue) => dropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: dropdownValue,
                    decoration: InputDecoration(
                      labelText: "Item Name",
                    ),
                    onChanged: (String newValue) {
                      dropdownValue = newValue;

                      AllinventoryItems i = allInventory.object.items
                          .singleWhere((element) =>
                      element.id == int.parse(newValue));
                      quantityInStock = i.quantityInStock;

                      setState(() {
                        showQuantity = true;
                        print("new value is a $dropdownValue");
                      });
                    },
                    items: allInventory.object.items
                        .map((AllinventoryItems inventory) {
                      return DropdownMenuItem<String>(
                          value: inventory.id.toString(),
                          child: Text(inventory.itemName));
                    }).toList()),
                (!showQuantity)
                    ? SizedBox()
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Quantity in stock is $quantityInStock',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DropdownSearch<String>(
                  validator: (vehicledropdownValue) =>
                  vehicledropdownValue == null
                      ? "Fields are required"
                      : null,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: vehicleModel.object.items
                      .map((VehicleItems vehicleitem) =>
                  vehicleitem.registrationNumber)
                      .toList(),
                  label: "Select Vehicle",
                  hint: "Select Vehicle",
                  showSearchBox: true,
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (String newValue) {
                    vehicledropdownValue = newValue;
                    setState(() {
                      print("new value is vutftf $newValue");
                    });
                  },
                ),
                SizedBox(height: 5),
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
                SizedBox(height: 5),
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
                DropdownButtonFormField<String>(
                    validator: (waredropdownValue) =>
                    waredropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: waredropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        warehouseSelected = false;
                        waredropdownValue = newValue;
                        getWarehousebin(newValue);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Warehouse",
                    ),
                    items: warehouseModel.object.items
                        .map((WarehouseItems warehouse) {
                      return DropdownMenuItem<String>(
                          value: warehouse.id.toString(),
                          child: Text(warehouse.warehouseName));
                    }).toList()),
                SizedBox(height: 5),
                (!warehouseSelected)
                    ? SizedBox()
                    : DropdownButtonFormField<String>(
                    validator: (warebindropdownValue) =>
                    warebindropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: warebindropdownValue,
                    onChanged: (String newValue) {
                      warebindropdownValue = newValue;
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Warehoue bin",
                    ),
                    items: warehouseBinModel.object
                        .map((WarehousebinObject binobject) {
                      return DropdownMenuItem<String>(
                          value: binobject.id.toString(),
                          child: Text(binobject.warehouseBinName));
                    }).toList()),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                    validator: (mechdropdownValue) =>
                    mechdropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: mechdropdownValue,
                    onChanged: (String newValue) {
                      mechdropdownValue = newValue;
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Mechanic",
                    ),
                    items: mechanicModel.object.items
                        .map((MechanicItems mechanicitems) {
                      return DropdownMenuItem<String>(
                          value: mechanicitems.id.toString(),
                          child: Text(mechanicitems.name));
                    }).toList()),
                SizedBox(height: 5),
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
                DropdownButtonFormField<String>(
                    validator: (drivdropdownValue) =>
                    drivdropdownValue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: drivdropdownValue,
                    onChanged: (String newValue) {
                      drivdropdownValue = newValue;
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Driver",
                    ),
                    items: driverModel.object.items
                        .map((DriverItems driveritems) {
                      return DropdownMenuItem<String>(
                          value: driveritems.id.toString(),
                          child: Text(driveritems.name));
                    }).toList()),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                    validator: (companytypevalue) =>
                    companytypevalue == null
                        ? "Fields are required"
                        : null,
                    isExpanded: true,
                    isDense: false,
                    value: companytypevalue,
                    onChanged: (String newValue) {
                      companytypevalue = newValue;
                      print('hhhhh$newValue}');
                      setState(() {
                        print("new value is $newValue");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "CompanyType",
                    ),
                    items: companyTypeModel.object.items
                        .map((CompanyItems companyItems) {
                      return DropdownMenuItem<String>(
                          value: companyItems.name,
                          child: Text(companyItems.name));
                    }).toList()),
                SizedBox(height: 5),
                DropdownButtonFormField(
                  validator: (creditTypeValue) => creditTypeValue == null
                      ? "Fields are required"
                      : null,
                  isDense: false,
                  isExpanded: true,
                  value: singleRequestItem["itemCond"] == null
                      ? "Select type"
                      : creditType[
                  int.parse(singleRequestItem["itemCond"])],
                  onChanged: (value) {
                    creditTypeValue = value;
                    setState(() {
                      singleRequestItem["itemCond"] =
                          creditType.indexOf(value).toString();
                      print("this is $value");
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Credit type",
                  ),
                  items: creditType.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                        child: Text(item), value: item);
                  }).toList(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }
                    if (quantityInStock < int.parse(value)) {
                      print(quantityInStock);
                      return "the quantity in stock is $quantityInStock ";
                    }
                    return null;
                  },
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Quantity",
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.only(top: 14.0),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: TextField(
                    controller: note,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Enter a note",
                      labelText: "Note",
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                        elevation: 5,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          print("submit");

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
                          print("printed");
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

buildDialog(
    BuildContext context,
    ) {
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
                          Navigator.pop(context);
                          // int count = 0;
                          // Navigator.popUntil(context, (route) {
                          //   return count++ == 2;



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
