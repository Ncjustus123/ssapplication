import 'package:driver_salary/api_response.dart';
import 'package:driver_salary/app_prefs.dart';
import 'package:driver_salary/authentication_models.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/report.dart';
import 'package:driver_salary/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
//  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  String username;
  String password;
  AppPreference instance;

  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final _formKeyLogIn = GlobalKey<FormState>();

  final passwordFocus = FocusNode();

  BuildContext _context;

  @override
  void initState() {
    passwordController.text = "123456";
    userController.text = "P100@LIBMOT.COM";
//    startServices();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          Builder(builder: (context) {
            _context = context;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        child: Text(
                          "Pilot Login",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Form(
                        key: _formKeyLogIn,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocus);
                                  },
                                  validator: (valueUserInfo) {
                                    if (valueUserInfo.isEmpty) {
                                      return "username";
                                    } else {
                                      username = valueUserInfo;
                                      print('Your user name is ' +
                                          valueUserInfo.toString());
                                    }
                                    return null;
                                  },
                                  controller: userController,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(20)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      labelText: 'Username or Phone Number',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      labelStyle: TextStyle(
                                        color: Colors
                                            .grey, //This is an example of a change
                                      )),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    focusNode: passwordFocus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    validator: (valuePassword) {
                                      if (valuePassword.isEmpty ||
                                          valuePassword.length < 6) {
                                        return "Password cannot be empty or lesser than 6 characters";
                                      } else {
                                        print("The password is $valuePassword");
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        labelText: 'Password',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        labelStyle: TextStyle(color: Colors.black)),
                                    obscureText: true,
                                  ),
                                )),
                            Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.only(top: 50.0, left: 50, right: 50),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  padding: EdgeInsets.only(top: 11.0, bottom: 11.0),
                                  color: Colors.red[500],
                                  onPressed: () {
                                    if (!_formKeyLogIn.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              'Make sure all fields are correctly filled!')));
                                    } else {
                                      //if fields validation is successful, make API call and do what needs to be done!
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
//                            showDialog();
                                      logInUser();
                                    }
                                  },
                                  child: Text(
                                    'log in'.toUpperCase(),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  textColor: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            //forgot password
                            Container(
                              margin: EdgeInsets.only(left: 1.5, top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  print('User forgot password');
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        (_loading)?Container(
          color: Colors.white70,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ):SizedBox() ],
      ),
    );
  }

  void logInUser() async {
    setState(() {
      _loading = true;
    });
    try {
      TokenRequestObject requestObject =
          TokenRequestObject(passwordController.text, userController.text);
      APIResponse<TokenResponseObject> response =
          ServiceUtilities.decorateTokenResponse<TokenResponseObject>(
              await AuthenticationClient.create()
                  .getToken(requestObject.toJSON()),
              TokenResponseObject());
      if (response.code == "200") {
//        AppUtilities.showSnackBar(context, "Login Successful");

        print(response.payload.access_token);
        await AppPreference.getInstance().then((instance) async {
          instance.setUserCredentials(requestObject);
          instance.setBoolPref(AppPreference.loggedIn, true);
          await startServices(response.payload.access_token);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Report(token: response.payload.access_token)),
              ModalRoute.withName("/Home"));
        });
      } else {}
      setState(() {
      _loading = false;
    });
    } catch (e) {
      setState(() {
      _loading = false;
    });
      print("There is an error: $e");
      AppUtilities.showSnackBar(_context, e.toString());
    }
  }

  String message = 'Please enter a valid email';

  dynamic validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]'
        r'+(\.[^<>()[\]\\.,;:\s@\"]+'
        r')*)|(\".+\"))@((\[[0-9]{1,3}\'
        r'.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]'
        r'{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return message;
    } else {
      return true;
    }
  }

  Future<void> startServices(String token) async {
    GetIt.I.reset();
    GetIt.I
        .registerLazySingleton(() => AuthenticationClient.create(token: token));
  }
}
