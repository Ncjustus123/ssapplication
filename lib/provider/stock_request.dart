import 'package:chopper/chopper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Reusables/ui_reusable.dart';
import 'package:driver_salary/model/getClaimsModel.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/model/profilemodel.dart';
import 'package:driver_salary/provider/service_request.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../authentication_service.dart';
import '../main.dart';

class StockRequestProvider with ChangeNotifier {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  bool haveAccessToApproveRequest = false;
  bool haveAccessToVerifyRequest = false;
  bool haveAccessToissueRequest = false;
  InventoryModel inventoryModel;

  checkClaims() async {
    ProfileModelObject claims;
    final String approveRequest = "approveRequest";
    final String verifyRequest = "verifyRequest";
    final String issueRequest = "issueRequest";
    AppPreference getProfileClaims = await AppPreference.getInstance();
    claims = getProfileClaims.getUseDetails();
    print(claims);

    ClaimsObject obj = claims.claimsObject
        .singleWhere((element) => element.value == approveRequest);

    ClaimsObject obj2 = claims.claimsObject
        .singleWhere((element) => element.value == verifyRequest);

    ClaimsObject obj3 = claims.claimsObject
        .singleWhere((element) => element.value == issueRequest);

    if (obj != null) {
      haveAccessToApproveRequest = true;
    }

    if (obj2 != null) {
      haveAccessToVerifyRequest = true;
    }

    if (obj3 != null) {
      haveAccessToissueRequest = true;
    }
  }


  Loading status = Loading.loading;
  List<InventoryItems> pendingList = [];
  List<InventoryItems> verifiedList = [];
  List<InventoryItems> approvedList = [];
  List<InventoryItems> issuedList = [];

  List<int> selectedAwaitingVerification = [];
  List<int> selectedAwaitingApproval = [];
  List <int> selectedAwaitingIssue = [];
  int count = 0;


  multipleRequest(context) async {
    showLoading(
        progressColor: Colors.purple,
        indicatorColor: Colors.purple,
        backgroundColor: Colors.white,
        textColor: Colors.purple,
        indicatorType: EasyLoadingIndicatorType.fadingCircle,
        status: "Submitting.....");
    Response response1, response2,response3;
    if (selectedAwaitingVerification.isNotEmpty) {
      response1 = await authClient.verifymultiplestockreq(selectedAwaitingVerification);
    }

    if (selectedAwaitingApproval.isNotEmpty) {
      response2 = await authClient.approvemultiplestockreq(selectedAwaitingApproval);
    }
    if (selectedAwaitingIssue.isNotEmpty) {
      response3 = await authClient.issuemultiplestockreq(selectedAwaitingIssue);
    }

    if ((selectedAwaitingVerification.isNotEmpty && response1.isSuccessful) ||
        (selectedAwaitingApproval.isNotEmpty && response2.isSuccessful)||
        (selectedAwaitingIssue.isNotEmpty && response3.isSuccessful) ) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Success"),
        duration: Duration(
          seconds: 5,
        ),
      ));
      Navigator.popUntil(context, (route) {
        return count++ == 3;
      });
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error"),
      ));
    }
  }


  Future<void> getAllinventory() async {
    InventoryModel inventoryModel;
    status = Loading.loading;
    notifyListeners();
    Response response = await authClient.getAllinventory();
    inventoryModel = InventoryModel.fromJson(response.body);
    for (InventoryItems request in inventoryModel.object.items){
      if(!request.isVerified){
        pendingList.add(request);
      }else if (request.isApproved && !request.isIssued){
        approvedList.add(request);
      }else if (request.isVerified && !request.isApproved){
        verifiedList.add(request);
      }else if (request.isVerified || request.isApproved || !request.isIssued){
        issuedList.add(request);
      }
    }
    status = Loading.loadingDone;
    notifyListeners();

  }

  actionCall(InventoryItems item, int id, methods action, BuildContext context) async {
    Response response;
    String status;
    String responseResult;
    showLoadingIndicator(status: status);

    switch (action) {
      case methods.approved:
        status = "Approving...";
        responseResult = "Approved";
        response = await authClient.approved(id, item.toJson());
        break;
      case methods.verify:
        status = "Verifying...";
        responseResult = "Verified";
        response = await authClient.verify(id, item.toJson());
        break;
      case methods.issue:
        status = "Issuing...";
        responseResult = "Issued";
        response = await authClient.issue(id, item.toJson());
        break;
      case methods.cancel:
        status = "cancelling....";
        responseResult = "Cancelled";
        response = await authClient.cancel(id, item.toJson());
        break;
    }

    if (response.isSuccessful) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: responseResult,
        confirmBtnColor: Colors.green,
        backgroundColor: Colors.green,
        onConfirmBtnTap: () {
          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 4;
          });
          //setState(() {});
        },
      );

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      print(response.error);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "error!",
          onConfirmBtnTap: () {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 4;
            });

          },
          confirmBtnColor: Colors.red,
          backgroundColor: Colors.red);
    }
  }

  void editAwaitingVerification(int index, int action , int listype) {
    if (action == 1) {

      //add to awaitingVerification list
      switch (listype){
        case 0:
          selectedAwaitingVerification.add(pendingList[index].id);
          break;
        case 1:
          selectedAwaitingApproval.add(verifiedList[index].id);
          break;
        case 2:
          selectedAwaitingIssue.add(approvedList[index].id);
          break;

      }

    } else {
      //remove from awaitingVerification list
      switch (listype){
        case 0:
          selectedAwaitingVerification.remove(pendingList[index].id);
          break;
        case 1:
          selectedAwaitingApproval.remove(verifiedList[index].id);
          break;
        case 2:
          selectedAwaitingIssue.remove(approvedList[index].id);
          break;
      }

    }
    notifyListeners();
  }
  bool boolValueType(int listType, int id){
    switch(listType){
      case 0:
        return (selectedAwaitingVerification.contains(id)) ? true : false;
        break;
      case 1:
        return (selectedAwaitingApproval.contains(id)) ? true : false;
        break;
      case 2:
        return (selectedAwaitingIssue.contains(id))? true : false;
        break;
      default:
        return false;
    }

  }
}


enum Loding { loading, loadingDone }
enum methods {
  approved,
  verify,
  cancel,
  issue,
}
