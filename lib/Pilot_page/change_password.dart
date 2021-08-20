import 'package:driver_salary/Functions/CustomWidget.dart';
import 'package:driver_salary/Functions/api_response.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/Functions/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = "change_password";

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _loading = false;
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  final _formKey = GlobalKey<FormState>();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  TextEditingController cPassContr = TextEditingController();
  TextEditingController c1Contr = TextEditingController();
  TextEditingController c2Contr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomWidget.getAppBar(context, "Change Password", true),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),

                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(f1);
                              },
                              validator: (valueUserInfo) {
                                if (valueUserInfo.isEmpty) {
                                  return "Please enter your current password";
                                }
                                return null;
                              },
                              controller: cPassContr,
                              decoration:
                              CustomWidget.getInputDeco("Current Password"),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                focusNode: f1,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(f2);
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
                                controller: c1Contr,
                                decoration:
                                CustomWidget.getInputDeco("New password"),
                                obscureText: true,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                focusNode: f2,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                validator: (valuePassword) {
                                  if (valuePassword != c1Contr.text) {
                                    return "Password does not match with previous";
                                  }
                                  return null;
                                },
                                controller: c2Contr,
                                decoration:
                                CustomWidget.getInputDeco("Confirm password"),
                                obscureText: true,
                              ),
                            )),
                        Container(
                            height: 45,
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 50.0, bottom: 11.0, left: 40, right: 40),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),


                              color: Colors.red,
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Make sure all fields are correctly filled!')));
                                } else {
                                  //if fields validation is successful, make API call and do what needs to be done!
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  changePassword();
                                }
                              },
                              child: Text(
                                'Change Password'.toUpperCase(),
                                style: TextStyle(fontSize: 15.0),
                              ),
                              textColor: Colors.white,
                            )),
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
        ),
      ),
    );
  }

  void changePassword() async {
    setState(() {
      _loading = true;
    });
    changePassReqObject request = changePassReqObject(
        cPassContr.text,
        c2Contr.text);
    APIResponse response = ServiceUtilities.decorateResponse(
        await authClient.changePassword(request.toJSON()), null);

    if (response.code != 1) {
      await CustomWidget.showCustomDialog(
          DialogType.error, context, response.description, "Close", () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    } else {
      await CustomWidget.showCustomDialog(
          DialogType.success, context, response.description, "Close", () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    setState(() {
      _loading = false;
      c1Contr.text = "";
      cPassContr.text = "";
      c2Contr.text = "";
    });
  }
}
