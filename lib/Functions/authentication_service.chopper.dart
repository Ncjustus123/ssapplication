// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../authentication_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthenticationClient extends AuthenticationClient {
  _$AuthenticationClient([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthenticationClient;

  @override
  Future<Response<dynamic>> getToken(Map<String, dynamic> json) {
    final $url = 'api/Token';
    final $body = json;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPilotWallet(String email) {
    final $url = '/api/Driver/GetDriverByEmail/$email';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> getProfile() {
    final $url = 'api/account/getprofile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> getClaims() {
    final $url = 'api/Account/GetCurrentUserClaims';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> verify(id, Map itemList) {
    final $url = '/api/InventoryRequests/VerifyRequest/$id';
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> verifymultiplestockreq(List <int> id,)  {
    final $url = '/api/InventoryRequests/VerifyRequestb';
    final $request = Request('PUT', $url, client.baseUrl, body: id);
    return client.send<dynamic, dynamic>($request);
  }
// Map itemList
  @override
  Future<Response<dynamic>> verifysingleService(id,Map itemList ) {
    final $url = '/api/ServiceRequest/VerifyRequest/$id';
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> verifyService(List <int> id, ) {
    final $url = '/api/ServiceRequest/VerifyRequest';
    final $request = Request('PUT', $url, client.baseUrl, body: id);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> approved(id, Map itemList) {
    final $url = '/api/InventoryRequests/ApproveRequest/$id';
    final $body = itemList;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> approvemultiplestockreq(List <int> id,)  {
    final $url = '/api/InventoryRequests/ApproveRequest';
    final $request = Request('PUT', $url, client.baseUrl, body: id);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> approvedService(List <int> id) {
    final $url = '/api/ServiceRequest/ApproveRequest';
    // final $body = itemList;
    final $request = Request('PUT', $url, client.baseUrl, body: id);
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> approvedsingleService(int id, Map itemList) {
    final $url = '/api/ServiceRequest/ApproveRequest/$id';
    // final $body = itemList;
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> cancel(id , Map itemList) {
    final $url = '/api/InventoryRequests/CancelRequest/$id';
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }


  @override
  Future<Response<dynamic>> cancelService(id , Map itemList) {
    final $url = '/api/ServiceRequest/CancelRequest/$id';
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> issue(id , Map itemList) {
    final $url = '/api/InventoryRequests/IssueRequest/$id';
    final $request = Request('PUT', $url, client.baseUrl, body: itemList);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> issuemultiplestockreq(List <int> id,)  {
    final $url = '/api/InventoryRequests/IssueRequest';
    final $request = Request('PUT', $url, client.baseUrl, body: id);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getReport(Map<dynamic, dynamic> body) {
    final $url = '/api/Driver/SearchPilotPaySlip';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changePassword(Map<dynamic, dynamic> body) {
    final $url = '/api/Account/ChangePassword';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }



  @override
  Future<Response<dynamic>> getAllInventoryitemname() {
    final $url = 'api/Inventory/GetAllInventory';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getVehicles() {
    final $url = 'api/vehicle/get';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getIssue() {
    final $url = 'api/Issue/GetAllIssue';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDepartment() {
    final $url = 'api/Departments/GetAllDepartments';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWarehouse() {
    final $url = 'api/InventorySetup/GetAllWarehouses';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWarehousebin(String warehouseId) {
    final $url = 'api/InventorySetup/GetBinByWarehouseId/$warehouseId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMechanic() {
    final $url = 'api/Mechanic/GetAllMechanic';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDrivers() {
    final $url = 'api/driver/get';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getcancelledStockreqeust() {
    final $url = 'api/InventoryRequests/GetCancelledRequests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getcancelledServiceRequest() {
    final $url = '/api/ServiceRequest/GetCancelledRequests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTerminal() {
    final $url = 'api/terminal/get';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllinventory() {
    final $url = 'api/InventoryRequests/GetAllRequests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> requestCreate (Map<dynamic, dynamic> body) {
    final $url = '/api/InventoryRequests/AddRequest';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> serviceRequestCreate (Map<dynamic, dynamic> body) {
    final $url = 'api/ServiceRequest/AddRequest';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> companyTypes() {
    final $url = 'api/CompanyTypes/GetAllCompanyTypes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
  @override
  Future<Response<dynamic>> getServiceRequest() {
    final $url = 'api/ServiceRequest/GetAllRequests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }


}

