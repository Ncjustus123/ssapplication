class WarehouseModel {
  String code;
  String shortDescription;
  Object object;

  WarehouseModel({this.code, this.shortDescription, this.object});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
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
  List<WarehouseItems> items;
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
      items = new List<WarehouseItems>();
      json['items'].forEach((v) {
        items.add(new WarehouseItems.fromJson(v));
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

class WarehouseItems {
  String warehouseCode;
  String warehouseName;
  String warehouseState;
  String warehouseZip;
  bool isActive;
  int companyId;
  bool isDeleted;
  String creationTime;
  int id;

  WarehouseItems(
      {this.warehouseCode,
        this.warehouseName,
        this.warehouseState,
        this.warehouseZip,
        this.isActive,
        this.companyId,
        this.isDeleted,
        this.creationTime,
        this.id});

  WarehouseItems.fromJson(Map<String, dynamic> json) {
    warehouseCode = json['warehouseCode'];
    warehouseName = json['warehouseName'];
    warehouseState = json['warehouseState'];
    warehouseZip = json['warehouseZip'];
    isActive = json['isActive'];
    companyId = json['companyId'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouseCode'] = this.warehouseCode;
    data['warehouseName'] = this.warehouseName;
    data['warehouseState'] = this.warehouseState;
    data['warehouseZip'] = this.warehouseZip;
    data['isActive'] = this.isActive;
    data['companyId'] = this.companyId;
    data['isDeleted'] = this.isDeleted;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
