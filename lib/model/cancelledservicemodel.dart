class CancelledServiceReq {
  String code;
  String shortDescription;
  Object object;

  CancelledServiceReq({this.code, this.shortDescription, this.object});

  CancelledServiceReq.fromJson(Map<String, dynamic> json) {
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
  List<CancelledItems> items;
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
      items = new List<CancelledItems>();
      json['items'].forEach((v) {
        items.add(new CancelledItems.fromJson(v));
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
class CancelledItems {
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
  int departmentID;
  String departmentName;
  String requestedBy;
  bool isCaptured;
  bool isVerified;
  bool isApproved;
  bool isIssued;
  bool isCancelled;
  int issueId;
  int quantityReleased;
  int quantityInStock;
  bool isDeleted;
  String creationTime;
  int id;

  CancelledItems(
      {this.companyId,
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
        this.departmentID,
        this.departmentName,
        this.requestedBy,
        this.isCaptured,
        this.isVerified,
        this.isApproved,
        this.isIssued,
        this.isCancelled,
        this.issueId,
        this.quantityReleased,
        this.quantityInStock,
        this.isDeleted,
        this.creationTime,
        this.id});

  CancelledItems.fromJson(Map<String, dynamic> json) {
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
    isCaptured = json['isCaptured'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isIssued = json['isIssued'];
    isCancelled = json['isCancelled'];
    issueId = json['issueId'];
    quantityReleased = json['quantityReleased'];
    quantityInStock = json['quantityInStock'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
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
    data['issueId'] = this.issueId;
    data['quantityReleased'] = this.quantityReleased;
    data['quantityInStock'] = this.quantityInStock;
    data['isDeleted'] = this.isDeleted;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
