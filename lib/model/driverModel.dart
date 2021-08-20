class DriverModel {
  String code;
  String shortDescription;
  Object object;

  DriverModel({this.code, this.shortDescription, this.object});

  DriverModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
    json['object'] != null ? new Object.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.toJson();
    }
    return data;
  }
}

class Object {
  List<DriverItems> items;
  int count;
  int pageCount;
  int totalItemCount;
  int pageNumber;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;

  Object(
      {this.items,
        this.count,
        this.pageCount,
        this.totalItemCount,
        this.pageNumber,
        this.pageSize,
        this.hasPreviousPage,
        this.hasNextPage});

  Object.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<DriverItems>();
      json['items'].forEach((v) {
        items.add(new DriverItems.fromJson(v));
      });
    }
    count = json['count'];
    pageCount = json['pageCount'];
    totalItemCount = json['totalItemCount'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['pageCount'] = this.pageCount;
    data['totalItemCount'] = this.totalItemCount;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    return data;
  }
}

class DriverItems {
  int id;
  String code;
  int driverStatus;
  int driverType;
  int noOfTrips;
  String name;
  String phone1;
  String designation;
  String assignedDate;
  String residentialAddress;
  String nextOfKin;
  String dateCreated;
  String picture;
  bool active;
  String nextOfKinNumber;
  int walletId;
  String walletNumber;
  double walletBalance;
  String details;
  int vehId;
  String driverDetails;
  String licenseDate;
  double oldBalance;
  double balance;
  int userId;
  String alias;
  String dateOfEmployment;
  String bankAccount;
  String bankName;
  int duePeriod;
  String phone2;

  DriverItems(
      {this.id,
        this.code,
        this.driverStatus,
        this.driverType,
        this.noOfTrips,
        this.name,
        this.phone1,
        this.designation,
        this.assignedDate,
        this.residentialAddress,
        this.nextOfKin,
        this.dateCreated,
        this.picture,
        this.active,
        this.nextOfKinNumber,
        this.walletId,
        this.walletNumber,
        this.walletBalance,
        this.details,
        this.vehId,
        this.driverDetails,
        this.licenseDate,
        this.oldBalance,
        this.balance,
        this.userId,
        this.alias,
        this.dateOfEmployment,
        this.bankAccount,
        this.bankName,
        this.duePeriod,
        this.phone2});

  DriverItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    driverStatus = json['driverStatus'];
    driverType = json['driverType'];
    noOfTrips = json['noOfTrips'];
    name = json['name'];
    phone1 = json['phone1'];
    designation = json['designation'];
    assignedDate = json['assignedDate'];
    residentialAddress = json['residentialAddress'];
    nextOfKin = json['nextOfKin'];
    dateCreated = json['dateCreated'];
    picture = json['picture'];
    active = json['active'];
    nextOfKinNumber = json['nextOfKinNumber'];
    walletId = json['walletId'];
    walletNumber = json['walletNumber'];
    walletBalance = json['walletBalance'];
    details = json['details'];
    vehId = json['vehId'];
    driverDetails = json['driverDetails'];
    licenseDate = json['licenseDate'];
    oldBalance = json['oldBalance'];
    balance = json['balance'];
    userId = json['userId'];
    alias = json['alias'];
    dateOfEmployment = json['dateOfEmployment'];
    bankAccount = json['bankAccount'];
    bankName = json['bankName'];
    duePeriod = json['duePeriod'];
    phone2 = json['phone2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['driverStatus'] = this.driverStatus;
    data['driverType'] = this.driverType;
    data['noOfTrips'] = this.noOfTrips;
    data['name'] = this.name;
    data['phone1'] = this.phone1;
    data['designation'] = this.designation;
    data['assignedDate'] = this.assignedDate;
    data['residentialAddress'] = this.residentialAddress;
    data['nextOfKin'] = this.nextOfKin;
    data['dateCreated'] = this.dateCreated;
    data['picture'] = this.picture;
    data['active'] = this.active;
    data['nextOfKinNumber'] = this.nextOfKinNumber;
    data['walletId'] = this.walletId;
    data['walletNumber'] = this.walletNumber;
    data['walletBalance'] = this.walletBalance;
    data['details'] = this.details;
    data['vehId'] = this.vehId;
    data['driverDetails'] = this.driverDetails;
    data['licenseDate'] = this.licenseDate;
    data['oldBalance'] = this.oldBalance;
    data['balance'] = this.balance;
    data['userId'] = this.userId;
    data['alias'] = this.alias;
    data['dateOfEmployment'] = this.dateOfEmployment;
    data['bankAccount'] = this.bankAccount;
    data['bankName'] = this.bankName;
    data['duePeriod'] = this.duePeriod;
    data['phone2'] = this.phone2;
    return data;
  }
}
