// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_service.dart';

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
  Future<Response<dynamic>> getProfile(String email) {
    final $url = '/api/Driver/GetDriverByEmail/$email';
    final $request = Request('GET', $url, client.baseUrl);
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
}
