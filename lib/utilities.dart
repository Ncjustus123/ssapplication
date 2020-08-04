import 'dart:convert';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:driver_salary/api_response.dart';
import 'package:flutter/material.dart';

class EndPoint {
  static const String authenticationBaseURL =
      "http://libmotapidev.azurewebsites.net";

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  /// Authentication service END-POINTS
  static const String GET_TOKEN = "api/Token";
  static const String getDriverByEmail = "/api/Driver/GetDriverByEmail";
  static const String GET_OTP = "/api/AuthenticationApi/ResendActivationOTP";
  static const String CONFIRM_ACCOUNT =
      "/api/AuthenticationApi/ConfirmAccountPhoneNumber";
  static const String GET_PROFILE = "/api/AuthenticationApi/GetBasicProfile";
  static const String getPilotWallet = "/api/Driver/GetDriverByEmail/{email}";
  static const String changePassword = "/api/Account/ChangePassword";

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///Booking service END-POINT
  static const String getReport = "/api/Driver/SearchPilotPaySlip";

}

class ResponseCode {
  static const int ok = 200;
  static const int created = 201;
  static const int serverError = 500;
  static final int not_found = 404;
}

class ServiceUtilities {
  /// this method simple convert the http response to the object specified in @bluePrint
  /// in other the use this method, the object's class passed must inherit the Blueprint class
  static APIResponse decorateResponse<T>(
      Response response, BluePrint bluePrint) {
    APIResponse<T> apiResponse = APIResponse();
    Map object = json.decode(response.bodyString);
    apiResponse.code = object['code'];
    apiResponse.totalCount = object['totalCount'];
    apiResponse.statusCode = response.statusCode;
    apiResponse.description = object['description'];
    apiResponse.hasErrors = apiResponse.code != "200";
    apiResponse.errors = object['errors'];
    apiResponse.responseCode = object['responseCode'];
    apiResponse.raw = response.bodyString;
    if (response.statusCode >= 200 &&
        response.statusCode <= 300 &&
        !apiResponse.hasErrors) {
      if (bluePrint != null) {
        apiResponse.payload = bluePrint.fromJSON(object['object']);
      }
    }
    return apiResponse;
  }

  /// Similar to @decorateResponse but contains empty body since the token request response has no body.
  static APIResponse<TokenResponseObject>
      decorateTokenResponse<TokenResponseObject>(
          Response response, BluePrint bluePrint) {
    APIResponse<TokenResponseObject> apiResponse = APIResponse();
    Map object = json.decode(response.bodyString);
    apiResponse.code = response.statusCode.toString();
    apiResponse.totalCount = 0;
    apiResponse.description = "";
    apiResponse.statusCode = response.statusCode;
    apiResponse.hasErrors = (response.statusCode != ResponseCode.ok);
    apiResponse.responseCode = '${response.statusCode}';
    apiResponse.raw = response.bodyString;
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      apiResponse.payload = bluePrint.fromJSON(object['object']);
    }
    return apiResponse;
  }
}

class AppUtilities {
  static void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }

//  todayDate() {
//    var now = new DateTime.now();
//    var formatter = new DateFormat('dd-MM-yyyy');
//    String formattedTime = DateFormat('kk:mm:a').format(now);
//    String formattedDate = formatter.format(now);
//    print(formattedTime);
//    print(formattedDate);
//  }

  static String stringToTimeOfDay(String tod) {
    int hour = int.parse(tod.split(":")[0]);
    int minute = int.parse(tod.split(":")[1]);
    var a = "";
    var h = "";
    var m = "";
    if (hour > 12) {
      a = "pm";
      h = "${hour - 12}";
    } else {
      a = "am";
      h = "${hour}";
    }

    m = (minute > 9) ? "${minute}" : "0$minute";
    return "$h:$m $a";
  }
//
//  static Future<bool> checkLocationPermission() async {
//    final PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.location);
//    return permission == PermissionStatus.granted;
//  }
}

class MapUtilities {
  static double getDistance(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    var radlat1 = pi * lat1 / 180;
    var radlat2 = pi * lat2 / 180;
    var radlon1 = pi * lon1 / 180;
    var radlon2 = pi * lon2 / 180;
    var theta = lon1 - lon2;
    var radtheta = pi * theta / 180;
    var dist = sin(radlat1) * sin(radlat2) +
        cos(radlat1) * cos(radlat2) * cos(radtheta);
    dist = acos(dist);
    dist = dist * 180 / pi;
    dist = dist * 60 * 1.1515;
    if (unit == "K") {
      dist = dist * 1.609344;
    }
    if (unit == "N") {
      dist = dist * 0.8684;
    }
    return dist;
  }
}
