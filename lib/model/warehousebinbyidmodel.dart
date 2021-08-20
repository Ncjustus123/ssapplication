class WarehouseModelBinById {
  List<WarehousebinObject> object;

  WarehouseModelBinById({this.object});

  WarehouseModelBinById.fromJson(Map<String, dynamic> json) {
    if (json['object'] != null) {
      object = new List<WarehousebinObject>();
      json['object'].forEach((v) {
        object.add(new WarehousebinObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.object != null) {
      data['object'] = this.object.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehousebinObject {
  String warehouseBinIDCode;
  int warehouseID;
  String warehouseBinName;
  int warehouseBinWeight;
  double minimumQuantity;
  double maximumQuantity;
  bool isActive;
  int companyId;
  bool isDeleted;
  String creationTime;
  int id;

  WarehousebinObject(
      {this.warehouseBinIDCode,
        this.warehouseID,
        this.warehouseBinName,
        this.warehouseBinWeight,
        this.minimumQuantity,
        this.maximumQuantity,
        this.isActive,
        this.companyId,
        this.isDeleted,
        this.creationTime,
        this.id});

  WarehousebinObject.fromJson(Map<String, dynamic> json) {
    warehouseBinIDCode = json['warehouseBinIDCode'];
    warehouseID = json['warehouseID'];
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
