import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Pilot_page/LogIn.dart';
import 'package:driver_salary/model/wallet_service_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void logOut(context) {
  AppPreference.getInstance().then((pref) {
    pref.setBoolPref(AppPreference.loggedIn, false);
  });
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
      ModalRoute.withName("/Login"));
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
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Description",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
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
