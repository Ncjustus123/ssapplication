import 'package:driver_salary/Functions/CustomWidget.dart';


import 'package:driver_salary/Functions/api_response.dart';
import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/Pilot_page/change_password.dart';
import 'package:driver_salary/Reusables/method_reusable.dart';
import 'package:driver_salary/authentication_service.dart';

import 'package:driver_salary/inventory_page/welcome_page.dart';
import 'package:driver_salary/Functions/utilities.dart';
import 'package:driver_salary/model/wallet_service_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  double maxHeight;
  String _name = '';
  String pilotCode;

  dynamic currentMonthIndex;

  @override
  initState() {
    fetchDriverReport();
    currentMonthIndex = months[DateTime.now().month - 1];
    month = currentMonthIndex;
    year = DateTime.now().year.toString();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        maxHeight = MediaQuery.of(context).size.height - 140;
        h1 = maxHeight / 2;
        h2 = maxHeight / 2;
      });
    }).then((t) {
      getReport();
    });
  }

  dynamic month, year;

  double h1 = 0, h2 = 0;
  bool _loading = false;

  WalletTransactions _transactions = WalletTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              color: Colors.blueGrey[900],
            ),
            Container(
              transform: Matrix4.translationValues(0, 90, 0),
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(5))),
            ),
            Container(
              transform: Matrix4.translationValues(0, 40, 0),
              child: ListView(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Colors.grey[300],
                          offset: Offset(1.0, 1.0),
                          blurRadius: 0.0,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              // splashColor: Colors.red, // inkwell color
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[700],
                                ),
                              ),
                              onTap: () {
//                                showMenu();
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          _name.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontSize: 14, color: Colors.grey[700],fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    indent: 100,
                    endIndent: 5,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    title: Text("Change Password"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).push(createRoute(
                          ChangePasswordPage(), ChangePasswordPage.routeName));
                    },
                  ),
                  ListTile(
                    title: Text("Help and Support"),
                    leading: Icon(Icons.help),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Log out"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      logOut(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 10,
        title: Text('Pilot Salary',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "PaySlip for the month of :   ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          Expanded(
                            child: DropdownButton(
                              value: currentMonthIndex,
                              isExpanded: true,
                              hint: Text(
                                "month",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[800]),
                              onChanged: (value) {
                                setState(() {
                                  currentMonthIndex = value;
                                });
                                getReport();
                              },
                              items: months.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              value: year,
                              isExpanded: true,
                              hint: Text(
                                "year",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[800]),
                              onChanged: (value) {
                                setState(() {
                                  year = value.toString();
                                });
                              },
                              items: List<String>.generate(
                                  10,
                                      (index) => (DateTime.now().year - index)
                                      .toString(),
                                  growable: true)
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 400),
                          height: h1,
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Credit Report",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[600]),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: RaisedButton(
                                          color: (h2 != 1)
                                              ? Colors.orange
                                              : Colors.red,
                                          textColor: Colors.white,
                                          child: Row(
                                            children: <Widget>[
                                              Text((h2 != 1)
                                                  ? "Expand"
                                                  : "Shrink"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                (h2 != 1)
                                                    ? Icons.zoom_out_map
                                                    : Icons.aspect_ratio,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (h2 == 1) {
                                                h1 = maxHeight / 2;
                                                h2 = maxHeight / 2;
                                              } else {
                                                h1 = maxHeight;
                                                h2 = 1;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                getHeader(Colors.green),
                                Expanded(
                                  child: (_transactions
                                      .getTransactions(0)
                                      .length >
                                      0)
                                      ? ListView.separated(
                                    physics: (h1 != 1)
                                        ? NeverScrollableScrollPhysics()
                                        : null,
                                    itemCount: _transactions
                                        .getTransactions(1)
                                        .length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 1,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return getRow(_transactions
                                          .getTransactions(1)[index]);
                                    },
                                  )
                                      : Container(
                                    alignment: Alignment.center,
                                    child: Text("No Record found!"),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.grey[500],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${_transactions.getBalance(1)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (h2 == 1) ? 0 : 1,
                        ),
                        AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 200),
                          height: h2,
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Debit Report",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: RaisedButton(
                                          color: (h1 != 1)
                                              ? Colors.orange
                                              : Colors.red,
                                          textColor: Colors.white,
                                          child: Row(
                                            children: <Widget>[
                                              Text((h1 != 1)
                                                  ? "Expand"
                                                  : "Shrink"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                (h1 != 1)
                                                    ? Icons.zoom_out_map
                                                    : Icons.aspect_ratio,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              print("show");
                                              if (h1 == 1) {
                                                h1 = maxHeight / 2;
                                                h2 = maxHeight / 2;
                                              } else {
                                                h1 = 1;
                                                h2 = maxHeight;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                getHeader(Colors.red),
                                Expanded(
                                  child: (_transactions
                                      .getTransactions(0)
                                      .length >
                                      0)
                                      ? ListView.separated(
                                    physics: (h2 != 1)
                                        ? NeverScrollableScrollPhysics()
                                        : null,
                                    itemCount: _transactions
                                        .getTransactions(0)
                                        .length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 1,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return getRow(_transactions
                                          .getTransactions(0)[index]);
                                    },
                                  )
                                      : Container(
                                    alignment: Alignment.center,
                                    child: Text("No Record found!"),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.grey[500],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${_transactions.getBalance(0)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (_loading)
                ? Container(
              color: Colors.white70,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
                : SizedBox()
          ],
        );
      }),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void fetchDriverReport() async {
    try {
      setState(() {
        _loading = true;
      });

      final prefs = await AppPreference.getInstance();
      TokenRequestObject object = prefs.getUserCredentials();

      APIResponse<DriverDetails> response =
      ServiceUtilities.decorateResponse<DriverDetails>(
          await AuthenticationClient.create().getPilotWallet(object.username),
          DriverDetails());
      print('yyy${object.username}');
      print(' vxc${response.payload}');
      if (!response.hasErrors) {
        AppPreference.getInstance().then((pref) {
          pref.setPref("name", response.payload.name);
          pref.setPref("walletId", response.payload.walletNumber);
          pref.setPref("nextOfKin", response.payload.nextOfKinNumber);
          pref.setPref("email", response.payload.email);
          pref.setInt("userId", response.payload.userId);
          pref.setInt("id", response.payload.id);
          pilotCode = response.payload.code;
          setState(() {
            _name = response.payload.name;
          });
        });
      }

      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  void getReport() async {
    try {
      setState(() {
        _loading = true;
      });

      ReportRequest request = ReportRequest(
          startDate: "$year-${months.indexOf(currentMonthIndex) + 1}-01",
          // code: "LIBMOT001");
          code: pilotCode);

      print(request.toJSON());
      APIResponse<WalletTransactions> response =
      ServiceUtilities.decorateResponse<WalletTransactions>(
          await GetIt.I<AuthenticationClient>().getReport(request.toJSON()),
          WalletTransactions());
      print("\n\n");
      print(response.payload.list.length);

      setState(() {
        _transactions = response.payload;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  List<String> months = [
    'January',
    'Febuary',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;
  final Widget child;

  ClipOvalShadow({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRect(child: child, clipper: this.clipper),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  _ClipOvalShadowPainter({@required this.shadow, @required this.clipper});

  final Shadow shadow;
  final CustomClipper<Rect> clipper;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(0, 0));
    canvas.drawOval(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
