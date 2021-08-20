import 'dart:convert';
import 'dart:math';
import 'package:chopper/chopper.dart';
import 'package:driver_salary/Functions/api_response.dart';
import 'package:flutter/material.dart';
import 'api_response.dart';

class EndPoint {
  static const String authenticationBaseURL = SystemProperties.development_url;
  //development_url//test

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
  static const String getProfile = "api/account/getprofile";
  static const String getPilotWallet = "/api/Driver/GetDriverByEmail/{email}";
  static const String changePassword = "/api/Account/ChangePassword";
  static const String getDrivers = "/api/driver/get";
  static const String getTerminal = "/api/terminal/get";
  static const String getcancelledStockreqeust =
      "/api/InventoryRequests/GetCancelledRequests";
  static const String getcancelledServiceRequest =
      "/api/ServiceRequest/GetCancelledRequests";

  ///
  ///
  ///
  ///
  ///
  /// Create Request End-points
  ///
  static const String getAllInventoryitemname = "api/Inventory/GetAllInventory";
  static const String getAllinventory = "api/InventoryRequests/GetAllRequests";
  static const String getVehicles = "api/vehicle/get";
  static const String getIssue = "api/Issue/GetAllIssue";
  static const String getDepartment = "api/Departments/GetAllDepartments";
  static const String getWarehouse = "api/InventorySetup/GetAllWarehouses";
  static const String getMechanic = "api/Mechanic/GetAllMechanic";
  static const String requestCreate = "api/InventoryRequests/AddRequest";
  static const String companyTypes = "api/CompanyTypes/GetAllCompanyTypes";
  // service Request
  static const String getServiceRequest = "api/ServiceRequest/GetAllRequests";
  static const String serviceRequestCreate = "api/ServiceRequest/AddRequest";
  static const String getClaims = "api/Account/GetCurrentUserClaims";
  static const String verify = "/api/InventoryRequests/VerifyRequest/{0}";
  static const String verifymultiplestockreq = "/api/InventoryRequests/VerifyRequestb";
  static const String approved = "/api/InventoryRequests/ApproveRequest/{0}";
  static const String approvemultiplestockreq="/api/InventoryRequests/ApproveRequest";
  static const String cancel = "/api/InventoryRequests/CancelRequest/{0}";
  static const String issue = "/api/InventoryRequests/IssueRequest/{0}";
  static const String issuemultiplestockreq = "/api/InventoryRequests/IssueRequest";
  static const String verifysingleService = "/api/ServiceRequest/VerifyRequest/{0}";
  static const String verifyService = "/api/ServiceRequest/VerifyRequest/{0}";
  static const String approvedService =
      "/api/ServiceRequest/ApproveRequest/{0}";
  static const String approvedsingleService =  "/api/ServiceRequest/ApproveRequest/{0}";
  static const String cancelService = "/api/ServiceRequest/CancelRequest/{0}";
  static const String getWarehousebin =
      "api/InventorySetup/GetBinByWarehouseId";

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///Booking service END-POINT
  static const String getReport = "/api/Driver/SearchPilotPaySlip";
  static const String getAllUserBookings = "/api/BookingApi/GetUserBookings";
  static const String getBookingDetails = "/api​/BookingApi​/GetBooking";

  static const String getAllPickUpPoint =
      "/api/PickupPointApi/GetAllPickupPoint";

  static const String getRoutePickUpPoint =
      "/api/RoutePickupPoint/GetRoutePickupPoints";
  static const String getAllRoute = "/api/RouteApi/GetAllRoutes";
  static const String searchTrips = "/api/TripApi/SearchTrips";

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///  Wallet service END_POINTS
  static const String createPaymentDetails =
      "/api/WalletApi/CreatePaymentDetail";
  static const String verifyPayment = "/api/WalletApi/VerifyPayment";
  static const String getWalletBalance = "/api/WalletApi/GetWalletBalance";
  static const String fundCustomerWallet = "/api/WalletApi/FundCustomerWallet";
  static const String transferFunds = "/api/WalletApi/WalletTransfer";
  static const String createCustomerWallet =
      "/api/WalletApi/CreateCustomerWallet";
  static const String getTransactions = "/api/WalletApi/WalletTransHistory";
  static const String debitCustomerWallet = "/aggregator/Booking/Pay";
}

class ResponseCode {
  static const int ok = 200;
  static const int created = 201;
  static const int serverError = 500;
  // ignore: non_constant_identifier_names
  static final int not_found = 404;
}

class ServiceUtilities {
  /// this method simple convert the http response to the object specified in @bluePrint
  /// in other the use this method, the object's class passed must inherit the Blueprint class
  static APIResponse decorateResponse<T>(
      Response response, BluePrint bluePrint) {
    APIResponse<T> apiResponse = APIResponse();
    print("response ${response.body}");
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
    print("apiresponse.code is ${apiResponse.code}");
    return apiResponse;
  }

  static APIResponse<AllInventoryObject>
  decorateAllInventoryResponse<AllInventoryObject>(
      Response response, BluePrint bluePrint) {
    APIResponse<AllInventoryObject> apiResponse = APIResponse();
    Map object = json.decode(response.bodyString);
    apiResponse.totalCount = 0;
    apiResponse.description = "";
    apiResponse.statusCode = response.statusCode;
    apiResponse.hasErrors = (response.statusCode != ResponseCode.ok);
    apiResponse.responseCode = '${response.statusCode}';
    apiResponse.raw = response.bodyString;
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      apiResponse.payload = bluePrint.fromJSON(object['object']);
    }
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

class SystemProperties {
  static const String production_url = "https://client.libmot.com/";
//  new
  static const String development_url =
      "https://libmotapidevrs.azurewebsites.net/";
  static const String appPackageAndroid = "com.libramotors.driver_salary";
  static const String appIDIOS = "";
}
