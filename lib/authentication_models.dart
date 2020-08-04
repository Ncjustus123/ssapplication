import 'api_response.dart';

class TokenRequestObject implements BluePrint {
  TokenRequestObject(this.password, this.username);

  factory TokenRequestObject.fromJson(Map json) {
    return TokenRequestObject(json['password'], json['username']);
  }

  final String password;
  final String username;

  @override
  TokenRequestObject fromJSON(dynamic json) {
    return TokenRequestObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map<String, String> json = Map();
    json['password'] = password;
    json['username'] = username;
    return json;
  }

  @override
  fromList(List list) {
    // TODO: implement fromList
    return null;
  }
}

class TokenResponseObject implements BluePrint<TokenResponseObject> {
  TokenResponseObject({this.access_token, this.token_type, this.expires_in});

  factory TokenResponseObject.fromJson(Map json) {
    return TokenResponseObject(
        access_token: json['token'],
        token_type: json['token'],
        expires_in: json['expires_in']);
  }

  final String access_token;
  final String token_type;
  final int expires_in;

  @override
  TokenResponseObject fromJSON(dynamic json) {
    // TODO: implement fromJSON
    return TokenResponseObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['token'] = access_token;
    json['token_type'] = token_type;
    json['expires_in'] = expires_in;
    return json;
  }

  @override
  TokenResponseObject fromList(List list) {
    // TODO: implement fromList
    return null;
  }
}

class SignUpRequestObject implements BluePrint {
  SignUpRequestObject(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.gender,
      this.password,
      this.dialingCode});

  factory SignUpRequestObject.fromJson(Map json) {
    return SignUpRequestObject(
        firstName: json['firstName'],
        lastName: json['lastname'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
        gender: json['gender'],
        dialingCode: json['dialingCode']);
  }

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int gender;
  final String password;
  final String dialingCode;

  @override
  SignUpRequestObject fromJSON(dynamic json) {
    return SignUpRequestObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['firstName'] = firstName;
    json['lastname'] = lastName;
    json['email'] = email;
    json['phoneNumber'] = phoneNumber;
    json['password'] = password;
    json['gender'] = gender;
    json['dialingCode'] = dialingCode;
    return json;
  }

  @override
  fromList(List list) {
    // TODO: implement fromList
    return null;
  }
}

class SignUpResponseObject implements BluePrint {
  SignUpResponseObject();

  @override
  SignUpResponseObject fromJSON(dynamic json) {
    // TODO: implement fromJSON
    return null;
  }

  @override
  Map toJSON() {
    // TODO: implement toJSON
    return null;
  }

  @override
  fromList(List list) {
    // TODO: implement fromList
    return null;
  }
}

class ProFileResponseObject implements BluePrint {
  ProFileResponseObject(
      {this.lastName,
      this.firstName,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.emailConfirmed,
      this.createdOnUtc,
      this.lastLoginDate,
      this.activated,
      this.roleName,
      this.userId});

  factory ProFileResponseObject.fromJson(Map json) {
    return ProFileResponseObject(
        lastName: json['lastName'],
        firstName: json['firstName'],
        fullName: json['fullName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        emailConfirmed: json['emailConfirmed'],
        createdOnUtc: json['createdOnUtc'],
        lastLoginDate: json['lastLoginDate'],
        activated: json['activated'],
        roleName: json['roleName'],
        userId: json['userId']);
  }

  final String lastName;
  final String firstName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final bool emailConfirmed;
  final String createdOnUtc;
  final String lastLoginDate;
  final bool activated;
  final String roleName;
  final String userId;

  @override
  ProFileResponseObject fromJSON(dynamic json) {
    return ProFileResponseObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['lastName'] = lastName;
    json['firstName'] = firstName;
    json['fullName'] = fullName;
    json['email'] = email;
    json['phoneNumber'] = phoneNumber;
    json['emailConfirmed'] = emailConfirmed;
    json['createdOnUtc'] = createdOnUtc;
    json['lastLoginDate'] = lastLoginDate;
    json['activated'] = activated;
    json['roleName'] = roleName;
    json['userId'] = userId;
    return json;
  }

  @override
  fromList(List list) {
    // TODO: implement fromList
    return null;
  }
}

class DriverDetails implements BluePrint {
  final int id;
  final String code;
  final String handoverCode;
  final int driverStatus;
  final String name;
  final bool active;
  final String nextOfKinNumber;
  final int walletId;
  final String walletNumber;
  final double walletBalance;
  final String details;

  final double balance;
  final int userId;
  final String email;

  DriverDetails(
      {this.id,
      this.code,
      this.handoverCode,
      this.driverStatus,
      this.name,
      this.active,
      this.nextOfKinNumber,
      this.walletId,
      this.walletNumber,
      this.walletBalance,
      this.details,
      this.balance,
      this.userId,
      this.email});

  @override
  fromJSON(json) {
    return DriverDetails(
      id: json['id'],
      email: json['email'],
      userId: json['userId'],
      walletId: json['walletId'],
      name: json['name'],
      active: json['active'],
      balance: json['balance'],
      code: json['code'],
      details: json['details'],
      driverStatus: json['driverStatus'],
      nextOfKinNumber: json['nextOfKinNumber'],
      walletBalance: json['walletBalance'],
      walletNumber: json['walletNumber'],
    );
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['id'] = id;
    json['email'] = email;
    json['userId'] = userId;
    json['walletId'] = walletId;
    json['name'] = name;
    json['active'] = active;
    json['balance'] = balance;
    json['code'] = code;
    json['details'] = details;
    json['driverStatus'] = driverStatus;
    json['nextOfKinNumber'] = nextOfKinNumber;
    json['walletBalance'] = walletBalance;
    json['walletNumber'] = walletNumber;
    return json;
  }
}


  class changePassReqObject implements BluePrint {
  changePassReqObject(this.currentPassword, this.newPasword);

  factory changePassReqObject.fromJson(Map json) {
    return changePassReqObject(json['currentPassword'], json['newPasword']);
  }

  final String currentPassword;
  final String newPasword;

  @override
  TokenRequestObject fromJSON(dynamic json) {
    return TokenRequestObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map<String, String> json = Map();
    json['currentPassword'] = currentPassword;
    json['newPassword'] = newPasword;
    return json;
  }


}
