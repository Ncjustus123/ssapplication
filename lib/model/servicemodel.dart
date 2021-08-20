class ServiceModel {
  String code;
  String shortDescription;
  ServiceObject object;

  ServiceModel({this.code, this.shortDescription, this.object});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object = json['object'] != null
        ? new ServiceObject.fromJson(json['object'])
        : null;
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

class ServiceObject {
  List<ServiceItems> items;
  int count;
  int pageCount;
  int totalItemCount;
  int pageNumber;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;

  ServiceObject(
      {this.items,
        this.count,
        this.pageCount,
        this.totalItemCount,
        this.pageNumber,
        this.pageSize,
        this.hasPreviousPage,
        this.hasNextPage});

  ServiceObject.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<ServiceItems>();
      json['items'].forEach((v) {
        items.add(new ServiceItems.fromJson(v));
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

class ServiceItems {
  int companyId;
  String requestDate;
  String approvedDate;
  String issuedDate;
  String verifiedDate;
  String cancelledDate;
  String referenceNumber;
  int warehouseID;
  int warehouseBinID;
  int driverID;
  int vehicleRegID;
  int itemID;
  String itemName;
  int quantity;
  int unit;
  double price;
  bool isPaid;
  String paidDate;
  int departmentID;
  String departmentName;
  String requestedBy;
  bool isCaptured;
  bool isVerified;
  bool isApproved;
  bool isIssued;
  bool isCancelled;
  String description;
  int issueId;
  String issueName;
  int quantityReleased;
  int quantityInStock;
  bool isDeleted;
  String creationTime;
  double vat;
  int id;
  String note;
  int terminalID;
  String companyTypeName;

  ServiceItems({
    this.companyId,
    this.requestDate,
    this.approvedDate,
    this.issuedDate,
    this.verifiedDate,
    this.cancelledDate,
    this.referenceNumber,
    this.warehouseID,
    this.warehouseBinID,
    this.driverID,
    this.vehicleRegID,
    this.itemID,
    this.itemName,
    this.quantity,
    this.unit,
    this.price,
    this.isPaid,
    this.paidDate,
    this.departmentID,
    this.departmentName,
    this.requestedBy,
    this.isCaptured,
    this.isVerified,
    this.isApproved,
    this.isIssued,
    this.isCancelled,
    this.description,
    this.issueId,
    this.issueName,
    this.isDeleted,
    this.creationTime,
    this.id,
    this.note,
    this.terminalID,
    this.companyTypeName,
  });

  ServiceItems.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    requestDate = json['requestDate'];
    approvedDate = json['approvedDate'];
    issuedDate = json['issuedDate'];
    verifiedDate = json['verifiedDate'];
    cancelledDate = json['cancelledDate'];
    referenceNumber = json['referenceNumber'];
    warehouseID = json['warehouseID'];
    warehouseBinID = json['warehouseBinID'];
    driverID = json['driverID'];
    vehicleRegID = json['vehicleRegID'];
    itemID = json['itemID'];
    itemName = json['itemName'];
    quantity = json['quantity'];
    unit = json['unit'];
    price = json['price'];
    departmentID = json['departmentID'];
    departmentName = json['departmentName'];
    requestedBy = json['requestedBy'];
    isPaid = json['isPaid'];
    paidDate = json['paidDate'];
    isCaptured = json['isCaptured'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isIssued = json['isIssued'];
    isCancelled = json['isCancelled'];
    issueId = json['issueId'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
    vat = json['vat'];
    note = json['note'];
    terminalID = json['terminalID'];
    companyTypeName = json['companyTypeName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['requestDate'] = this.requestDate;
    data['approvedDate'] = this.approvedDate;
    data['issuedDate'] = this.issuedDate;
    data['verifiedDate'] = this.verifiedDate;
    data['cancelledDate'] = this.cancelledDate;
    data['referenceNumber'] = this.referenceNumber;
    data['warehouseID'] = this.warehouseID;
    data['warehouseBinID'] = this.warehouseBinID;
    data['driverID'] = this.driverID;
    data['vehicleRegID'] = this.vehicleRegID;
    data['itemID'] = this.itemID;
    data['itemName'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['departmentID'] = this.departmentID;
    data['departmentName'] = this.departmentName;
    data['requestedBy'] = this.requestedBy;
    data['isCaptured'] = this.isCaptured;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isIssued'] = this.isIssued;
    data['isCancelled'] = this.isCancelled;
    data['description'] = this.description;
    data['issueId'] = this.issueId;
    data['departmentName'] = this.departmentName;
    data['isDeleted'] = this.isDeleted;
    data['isPaid'] = this.isPaid;
    data['paidDate'] = this.paidDate;
    data['creationTime'] = this.creationTime;
    data['issueName'] = this.issueName;
    data['id'] = this.id;
    data['note'] = this.note;
    data['vat'] = this.vat;
    data['terminalID'] = this.terminalID;
    data['companyTypeName'] = this.companyTypeName;
    return data;
  }
}
