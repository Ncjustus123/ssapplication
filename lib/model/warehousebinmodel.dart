class WarehouseBinModel {
  String code;
  String shortDescription;
  Object object;

  WarehouseBinModel({this.code, this.shortDescription, this.object});

  WarehouseBinModel.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
    json['object'] != null ? new Object.fromJson(json['object']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.toJson();
    }
    return data;
  }
}

class Object {
  List<Items> items;
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

  Object.fromJson(Map<dynamic, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
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

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
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

class Items {
  String warehouseBinIDCode;
  int warehouseID;
  String warehouseName;
  String warehouseBinName;
  int warehouseBinWeight;
  int minimumQuantity;
  int maximumQuantity;
  bool isActive;
  int companyId;
  bool isDeleted;
  String creationTime;
  int id;

  Items(
      {this.warehouseBinIDCode,
        this.warehouseID,
        this.warehouseName,
        this.warehouseBinName,
        this.warehouseBinWeight,
        this.minimumQuantity,
        this.maximumQuantity,
        this.isActive,
        this.companyId,
        this.isDeleted,
        this.creationTime,
        this.id});

  Items.fromJson(Map<String, dynamic> json) {
    warehouseBinIDCode = json['warehouseBinIDCode'];
    warehouseID = json['warehouseID'];
    warehouseName = json['warehouseName'];
    warehouseBinName = json['warehouseBinName'];
    warehouseBinWeight = json['warehouseBinWeight'];
    minimumQuantity = json['minimumQuantity'];
    maximumQuantity = json['maximumQuantity'];
    isActive = json['isActive'];
    companyId = json['companyId'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouseBinIDCode'] = this.warehouseBinIDCode;
    data['warehouseID'] = this.warehouseID;
    data['warehouseName'] = this.warehouseName;
    data['warehouseBinName'] = this.warehouseBinName;
    data['warehouseBinWeight'] = this.warehouseBinWeight;
    data['minimumQuantity'] = this.minimumQuantity;
    data['maximumQuantity'] = this.maximumQuantity;
    data['isActive'] = this.isActive;
    data['companyId'] = this.companyId;
    data['isDeleted'] = this.isDeleted;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
