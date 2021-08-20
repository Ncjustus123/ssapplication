class AddServiceRequest {
  String code;
  String shortDescription;
  bool object;

  AddServiceRequest({this.code, this.shortDescription, this.object});

  AddServiceRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object = json['object'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    data['object'] = this.object;
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
  String note;
  String creditType;
  int mechanicID;
  int terminalID;
  String companyType;
  int totalPrice;




  ServiceItems(
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
        this.id,
        this.note,
        this.creditType,
        this.mechanicID,
        this.terminalID,
        this.companyType,
        this.totalPrice,

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
    note = json['note'];
    creditType = json["creditType"];
    mechanicID = json ['mechanicID'];
    terminalID = json ['terminalID'];
    companyType = json['companyType'];
    totalPrice = json['totalPrice'];

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
    data['note'] = this.note;
    data['creditType']= this.creditType;
    data['mechanicID'] = this.mechanicID;
    data['terminalID'] = this.terminalID;
    data['companyType'] = this.companyType;
    data['totalPrice'] = this.totalPrice;

    return data;
  }
}
