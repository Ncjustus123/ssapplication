import 'package:chopper/chopper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:driver_salary/Functions/app_prefs.dart';
import 'package:driver_salary/Reusables/ui_reusable.dart';
import 'package:driver_salary/main.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/model/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:driver_salary/model/getClaimsModel.dart';

import '../authentication_service.dart';

class ServiceRequestProvider with ChangeNotifier {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  InventoryModel inventoryModel;
  bool haveAccessToApproveRequest = false;
  bool haveAccessToVerifyRequest = false;

  checkClaims() async {
    ProfileModelObject claims;
    final String approveRequest = "approveRequest";
    final String verifyRequest = "verifyRequest";

    AppPreference getProfileClaims = await AppPreference.getInstance();
    claims = getProfileClaims.getUseDetails();

    ClaimsObject obj = claims.claimsObject
        .singleWhere((element) => element.value == approveRequest);

    ClaimsObject obj2 = claims.claimsObject
        .singleWhere((element) => element.value == verifyRequest);

    if (obj != null) {
      haveAccessToApproveRequest = true;
    }

    if (obj2 != null) {
      haveAccessToVerifyRequest = true;
    }
  }

  Loading status = Loading.loading;

  List<InventoryItems> pendingList = [];
  List<InventoryItems> verifiedList = [];
  List<InventoryItems> approvedList = [];

  List<int> selectedAwaitingVerification = [];
  List<int> selectedAwaitingApproval = [];
  int count = 0;

  multipleRequest(context) async {
    showLoading(
        progressColor: Colors.purple,
        indicatorColor: Colors.purple,
        backgroundColor: Colors.white,
        textColor: Colors.purple,
        indicatorType: EasyLoadingIndicatorType.fadingCircle,
        status: "Submitting.....");
    Response response1, response2;
    if (selectedAwaitingVerification.isNotEmpty) {
      response1 = await authClient.verifyService(selectedAwaitingVerification);
    }

    if (selectedAwaitingApproval.isNotEmpty) {
      response2 = await authClient.approvedService(selectedAwaitingApproval);
    }

    if ((selectedAwaitingVerification.isNotEmpty && response1.isSuccessful) ||
        (selectedAwaitingApproval.isNotEmpty && response2.isSuccessful)) {
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

  Future<void> getServiceRequest() async {
    InventoryModel inventoryModel;
    status = Loading.loading;
    notifyListeners();
    Response response = await authClient.getServiceRequest();

    inventoryModel = InventoryModel.fromJson(response.body);

    for (InventoryItems request in inventoryModel.object.items) {
      if (!request.isVerified) {
        pendingList.add(request);
      } else if (request.isApproved) {
        approvedList.add(request);
      } else if (request.isVerified || !request.isApproved) {
        verifiedList.add(request);
      }
    }
    status = Loading.loadingDone;
    notifyListeners();
  }

  actionCall(
      InventoryItems item, int id, method action, BuildContext context) async {
    Response response;
    String status;
    String responseResult;
    showLoadingIndicator(status: status);

    switch (action) {
      case method.approved:
        status = "Approving...";
        responseResult = "Approved";
        response = await authClient.approvedsingleService(id, item.toJson());
        break;
      case method.verify:
        status = "Verifying...";
        responseResult = "Verified";
        response = await authClient.verifysingleService(id, item.toJson());
        break;
      case method.cancel:
        status = "cancelling....";
        responseResult = "Cancelled";
        response = await authClient.cancelService(id, item.toJson());
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
        },
      );

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();

      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "error!",
          onConfirmBtnTap: () {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 4;
            });
            //setState(() {});
          },
          confirmBtnColor: Colors.red,
          backgroundColor: Colors.red);
    }
  }

  void editAwaitingVerification(int index, int action, int listType) {
    if (action == 1) {
      //add to awaitingVerification list
      switch (listType) {
        case 0:
          selectedAwaitingVerification.add(pendingList[index].id);
          break;
        case 1:
          selectedAwaitingApproval.add(verifiedList[index].id);
          break;
      }
    } else {
      //remove from awaitingVerification list
      switch (listType) {
        case 0:
          selectedAwaitingVerification.remove(pendingList[index].id);
          break;
        case 1:
          selectedAwaitingApproval.remove(verifiedList[index].id);
          break;
      }
    }
    notifyListeners();
  }

  bool boolValueType(int listType, int id) {
    switch (listType) {
      case 0:
        return (selectedAwaitingVerification.contains(id)) ? true : false;
        break;
      case 1:
        return (selectedAwaitingApproval.contains(id)) ? true : false;
        break;
      default:
        return false;
    }
  }
}

enum Loading { loading, loadingDone }

enum method {
  approved,
  verify,
  cancel,
}
