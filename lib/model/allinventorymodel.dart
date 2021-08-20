class AllInventory {
  String code;
  String shortDescription;
  Object object;

  AllInventory({this.code, this.shortDescription, this.object});

  AllInventory.fromJson(Map<String, dynamic> json) {
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
  List<AllinventoryItems> items;
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
      items = new List<AllinventoryItems>();
      json['items'].forEach((v) {
        items.add(new AllinventoryItems.fromJson(v));
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

class AllinventoryItems {
  String code;
  int companyId;
  String captureDate;
  int itemID;
  String itemName;
  int warehouseID;
  String warehouseName;
  int warehouseBinID;
  String warehouseBinName;
  int vendorID;
  String vendorName;
  int quantity;
  int unit;
  double price;
  int quantityReleased;
  int quantityInStock;
  double vat;
  bool isDeleted;
  String creationTime;
  int id;

  AllinventoryItems(
      {this.code,
        this.companyId,
        this.captureDate,
        this.itemID,
        this.itemName,
        this.warehouseID,
        this.warehouseName,
        this.warehouseBinID,
        this.warehouseBinName,
        this.vendorID,
        this.vendorName,
        this.quantity,
        this.unit,
        this.price,
        this.quantityReleased,
        this.quantityInStock,
        this.vat,
        this.isDeleted,
        this.creationTime,
        this.id});

  AllinventoryItems.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    companyId = json['companyId'];
    captureDate = json['captureDate'];
    itemID = json['itemID'];
    itemName = json['itemName'];
    warehouseID = json['warehouseID'];
    warehouseName = json['warehouseName'];
    warehouseBinID = json['warehouseBinID'];
    warehouseBinName = json['warehouseBinName'];
    vendorID = json['vendorID'];
    vendorName = json['vendorName'];
    quantity = json['quantity'];
    unit = json['unit'];
    price = json['price'];
    quantityReleased = json['quantityReleased'];
    quantityInStock = json['quantityInStock'];
    vat = json['vat'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['companyId'] = this.companyId;
    data['captureDate'] = this.captureDate;
    data['itemID'] = this.itemID;
    data['itemName'] = this.itemName;
    data['warehouseID'] = this.warehouseID;
    data['warehouseName'] = this.warehouseName;
    data['warehouseBinID'] = this.warehouseBinID;
    data['warehouseBinName'] = this.warehouseBinName;
    data['vendorID'] = this.vendorID;
    data['vendorName'] = this.vendorName;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['quantityReleased'] = this.quantityReleased;
    data['quantityInStock'] = this.quantityInStock;
    data['vat'] = this.vat;
    data['isDeleted'] = this.isDeleted;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
