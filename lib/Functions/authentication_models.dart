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
  // ignore: override_on_non_overriding_member
  fromList(List list) {

    return null;
  }
}

class TokenResponseObject implements BluePrint<TokenResponseObject> {
  // ignore: non_constant_identifier_names
  TokenResponseObject({this.access_token, this.token_type, this.expires_in, this.user});

  factory TokenResponseObject.fromJson(Map json) {
    return TokenResponseObject(
        access_token: json['token'],
        token_type: json['token'],
        user: json['user'],
        expires_in: json['expires_in']);
  }

  // ignore: non_constant_identifier_names
  final String access_token;
  // ignore: non_constant_identifier_names
  final String token_type;
  // ignore: non_constant_identifier_names
  final int expires_in;
  final String user;

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
    json['user'] = user;
    return json;
  }

  @override
  // ignore: override_on_non_overriding_member
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
  // ignore: override_on_non_overriding_member
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
  // ignore: override_on_non_overriding_member
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
  // ignore: override_on_non_overriding_member
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

class AllInventoryObject implements BluePrint {
  final String code;
  final int companyId;
  final String captureDate;
  final int itemId;
  final String itemName;
  final int warehouseID;
  final String warehouseName;
  final String warehouseBinID;
  final String warehouseBinName;
  final int vendorId;
  final String venderName;
  final int quantity;
  final int unit;
  final double price;
  final int quantityReleased;
  final int quantityInStock;
  final double vat;
  final bool isDeleted;
  final String creationTime;
  final int id;

  AllInventoryObject(
      {this.code,
        this.companyId,
        this.captureDate,
        this.itemId,
        this.itemName,
        this.warehouseID,
        this.warehouseName,
        this.warehouseBinID,
        this.warehouseBinName,
        this.vendorId,
        this.venderName,
        this.quantity,
        this.unit,
        this.price,
        this.quantityReleased,
        this.quantityInStock,
        this.vat,
        this.isDeleted,
        this.creationTime,
        this.id});

  @override
  AllInventoryObject fromJSON(json) {
    return AllInventoryObject(
      code: json['code'],
      companyId: json['companyId'],
      captureDate: json['captureDate'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      warehouseID: json['warehouseID'],
      warehouseName: json['warehouseName'],
      warehouseBinID: json['warehouseBinID'],
      warehouseBinName: json['warehouseBinName'],
      vendorId: json['vendorId'],
      venderName: json['venderoName'],
      quantity: json['quantity'],
      unit: json['unit'],
      price: json['price'],
      quantityReleased: json['quantityReleased'],
      quantityInStock: json['quantityInStock'],
      vat: json['vat'],
      isDeleted: json['isDeleted'],
      creationTime: json['creationTime'],
      id: json['id'],
    );
  }

  @override
  Map toJSON() {
    Map json = Map();

    json['code'] = code;
    json['code'] = companyId;
    json['code'] = captureDate;
    json['code'] = itemId;
    json['code'] = itemName;
    json['code'] = warehouseID;
    json['code'] = warehouseName;
    json['code'] = warehouseBinID;
    json['code'] = warehouseBinName;
    json['code'] = vendorId;
    json['code'] = venderName;
    json['code'] = quantity;
    json['code'] = unit;
    json['code'] = price;
    json['code'] = quantityReleased;
    json['code'] = quantityInStock;
    json['code'] = vat;
    json['code'] = isDeleted;
    json['code'] = creationTime;
    json['code'] = id;
    return json;
  }
}
