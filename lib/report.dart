import 'package:driver_salary/CustomWidget.dart';
import 'package:driver_salary/LogIn.dart';
import 'package:driver_salary/api_response.dart';
import 'package:driver_salary/app_prefs.dart';
import 'package:driver_salary/authentication_models.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/change_password.dart';
import 'package:driver_salary/utilities.dart';
import 'package:driver_salary/wallet_service_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState(token: token);
  final String token;

  Report({this.token});
}

class _ReportState extends State<Report> {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  _ReportState({this.token});

  String token;
  double maxHeight;
  String _name = "";

  dynamic currentMonthIndex;

  @override
  initState() {
    fetchDriverReport();
    setUp();
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
              color: Colors.red[900],
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
                              TextStyle(fontSize: 17, color: Colors.grey[700]),
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
                    onTap: (){
                      Navigator.of(context).push(createRoute(ChangePasswordPage(), ChangePasswordPage.routeName));
                    },
                  ),
                  ListTile(
                    title: Text("Help and Support"),
                    leading: Icon(Icons.help),
                  ),
                  ListTile(
                    title: Text("Log out"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      logOut();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Pilot Salary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
//        backgroundColor: Colors.white,
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
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.grey[700]),
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
                    child: CircularProgressIndicator(),
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

  Widget getRow(TransactionObject t) {
    String date = DateFormat.yMd().format(DateTime.parse(t.transactionDate));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Text(date)),
          Expanded(flex: 1, child: Text(t.transDescription)),
          Expanded(
              flex: 1,
              child: Center(child: Text(t.transactionAmount.toString()))),
        ],
      ),
    );
  }

  Widget getHeader(Color color) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "Date",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Amount",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchDriverReport() async {
    try {
      setState(() {
        _loading = true;
      });

      APIResponse<DriverDetails> response =
          ServiceUtilities.decorateResponse<DriverDetails>(
              await AuthenticationClient.create().getProfile("P100@LIBMOT.COM"),
              DriverDetails());
      print(response.payload);
      if (!response.hasErrors) {
        AppPreference.getInstance().then((pref) {
          pref.setPref("name", response.payload.name);
          pref.setPref("walletId", response.payload.walletNumber);
          pref.setPref("nextOfKin", response.payload.nextOfKinNumber);
          pref.setPref("email", response.payload.email);
          pref.setInt("userId", response.payload.userId);
          pref.setInt("id", response.payload.id);
          setState(() {
            _name = pref.getString("name");
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
          code: "LIBMOT002");
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

  void setUp() async {
    try {
      setState(() {
        _loading = true;
      });
      await AppPreference.getInstance().then((pref) async {
        if (token == null) {
          TokenRequestObject requestObject = pref.getUserCredentials();
          APIResponse<TokenResponseObject> response =
              ServiceUtilities.decorateTokenResponse<TokenResponseObject>(
                  await AuthenticationClient.create()
                      .getToken(requestObject.toJSON()),
                  TokenResponseObject());
          print(response.raw);
          if (!response.hasErrors) {
            // register
            token = response.payload.access_token;
          } else {
            // log out
            pref.setBoolPref(AppPreference.loggedIn, false);
            Navigator.of(context).pop();
          }
        }
        await startServices(token);
        setState(() {
          _loading = false;
        });
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> startServices(String token) async {
    GetIt.I.reset();
    GetIt.I
        .registerLazySingleton(() => AuthenticationClient.create(token: token));
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

  void logOut() {
    AppPreference.getInstance().then((pref) {
      pref.setBoolPref(AppPreference.loggedIn, false);
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
        ModalRoute.withName("/Login"));
  }
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
