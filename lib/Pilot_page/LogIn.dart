import 'package:driver_salary/Functions/api_response.dart';
import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/Functions/loginbrain.dart';
import 'package:driver_salary/Pilot_page/report.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/inventory_page/dashboard.dart';
import 'package:driver_salary/main.dart';
import 'package:driver_salary/inventory_page/welcome_page.dart';

import 'package:driver_salary/Functions/utilities.dart';
import 'package:driver_salary/model/getClaimsModel.dart';
import 'package:driver_salary/model/profilemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import 'package:chopper/chopper.dart';

import '../authentication_service.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
//  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  String username;
  String password;
  AppPreference instance;
  bool _passwordVisible = true;
  ProfileModel profileModel;
  ClaimsModel claimsModel;

  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final _formKeyLogIn = GlobalKey<FormState>();

  final passwordFocus = FocusNode();

  BuildContext _context;
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  @override
  void initState() {
    //passwordController.text = "Lme@adm1n";
    //userController.text = "administrator@lme.com";
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

  getClaims() async {
    Response response = await authClient.getClaims();
    if (response.isSuccessful) {
      profileModel.object.claimsObject =
          ClaimsModel.fromJson(response.body).object;
    }
  }

  getProfile() async {
    Response response = await authClient.getProfile();
    if (response.isSuccessful) {
      profileModel = ProfileModel.fromJson(response.body);

      Response claimResponse = await authClient.getClaims();
      if (claimResponse.isSuccessful) {
        profileModel.object.claimsObject =
            ClaimsModel.fromJson(claimResponse.body).object;

        AppPreference profile = await AppPreference.getInstance();
        profile.saveUserDetails(profileModel.object);
        switch (profileModel.object.userType) {
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Report(),
              ),
            );
            break;
          case 3:
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Sorry cant login '),
                duration: Duration(seconds: 3),
              ),
            );
            break;
          default:
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => WelcomePage(
                        name: profileModel.object.firstName,
                        lname: profileModel.object.lastName)),
                ModalRoute.withName("/Home"));
        }
      }
    }
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
                          "Welcome",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to continue",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),

                      ),
                      SizedBox(
                        height: 80,
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
                                      prefixIcon:
                                      Icon(Icons.email, color: Colors.grey),
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
                                      labelText: 'Email or Phone Number',
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                                    obscureText: _passwordVisible,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                              !_passwordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.grey),
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
                                        labelStyle:
                                        TextStyle(color: Colors.grey)),
                                  ),
                                )),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 50.0, left: 50, right: 50),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding:
                                  EdgeInsets.only(top: 11.0, bottom: 11.0),
                                  color: Colors.red[500],
                                  onPressed: () {
                                    if (!_formKeyLogIn.currentState
                                        .validate()) {
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
          (_loading)
              ? Container(
            color: Colors.white70,
            alignment: Alignment.center,
            // child: CircularProgressIndicator(),
          )
              : SizedBox()
        ],
      ),
    );
  }

  void logInUser() async {
    showLoading(
        progressColor: Colors.red,
        indicatorColor: Colors.red,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        indicatorType: EasyLoadingIndicatorType.dualRing,
        status: "Please wait.....");
    setState(() {
      _loading = true;
    });
    try {
      TokenRequestObject requestObjects =
      TokenRequestObject(passwordController.text, userController.text);
      print("this is ${requestObjects.toString()}");
      APIResponse<TokenResponseObject> response =
      ServiceUtilities.decorateTokenResponse<TokenResponseObject>(
          await AuthenticationClient.create()
              .getToken(requestObjects.toJSON()),
          TokenResponseObject());
      if (response.code == "200") {
//        AppUtilities.showSnackBar(context, "Login Successful");
        TokenRequestObject requestObject =
        TokenRequestObject(passwordController.text, response.payload.user);
        print(response.payload.access_token);
        await AppPreference.getInstance().then((instance) async {
          instance.setUserCredentials(requestObject);
          instance.setBoolPref(AppPreference.loggedIn, true);
          await startServices(response.payload.access_token);
          //instance.set
          //registerServices(requestObject);
          getProfile();

          // Future.delayed(Duration(minutes: 1), () {
          //     final snackBar = SnackBar(content: Text('yaykdkdkejd dkdle'));
          //     Scaffold.of(context).showSnackBar(snackBar);
          // });
        });
      } else {}
      EasyLoading.dismiss();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      EasyLoading.dismiss();
      setState(() {
        _loading = false;
      });
      print("There is an error: $e");
      AppUtilities.showSnackBar(_context, e.toString());
    }
  }
}
