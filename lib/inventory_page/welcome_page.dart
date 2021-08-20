import 'package:driver_salary/Functions/api_response.dart';
import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/Functions/loginbrain.dart';
import 'package:driver_salary/Functions/utilities.dart';
import 'package:driver_salary/Pilot_page/report.dart';
import 'package:driver_salary/Reusables/method_reusable.dart';
import 'package:driver_salary/Reusables/ui_reusable.dart';
import 'package:driver_salary/inventory_page/dashboard.dart';
import 'package:driver_salary/inventory_page/inventory_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:get_it/get_it.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState(token: token);
  final String token;
  final String name;
  final String lname;

  WelcomePage({this.token, this.name, this.lname});
}

bool _loading = false;

class _WelcomePageState extends State<WelcomePage> {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  _WelcomePageState({this.token});

  String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          ),
                        ),
                      ),
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
                    title: Text(" Pilot Salary"),
                    leading: Icon(FontAwesomeIcons.creditCard),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Report()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Requisition"),
                    leading: Icon(Icons.assignment),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Inventory"),
                    leading: Icon(FontAwesomeIcons.wrench),
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
        title: Text('Libmot Self Service',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      body: WillPopScope(
        onWillPop: _onwillPopScope,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                color: Colors.grey[400],
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Hello ${widget.name} how are you today?'),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.2,
                      child: ReusableCard(
                        colour: Colors.red,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.cogs,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Libmot ops',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ReusableCard(
                      colour: Colors.blue,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.creditCard,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Pilot Salary',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Report()),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.2,
                      child: ReusableCard(
                        colour: Colors.green,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.assignment,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Requisition',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ReusableCard(
                      colour: Colors.purple,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.wrench,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Inventory',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  Future<bool> _onwillPopScope() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        contentPadding:
        const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
        title: new Text(
            'Are you sure?'),
        content: new Text('Do you want to exit the App ?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 12),
          new FlatButton(
            onPressed: () {
              logOut(context);
            },
            child: Text(
              "YES",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }
}