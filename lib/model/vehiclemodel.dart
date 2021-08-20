class VehiclesModel {
  String code;
  String shortDescription;
  Object object;

  VehiclesModel({this.code, this.shortDescription, this.object});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
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
  List<VehicleItems> items;
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
      items = new List<VehicleItems>();
      json['items'].forEach((v) {
        items.add(new VehicleItems.fromJson(v));
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

class VehicleItems {
  String details;
  int id;
  String registrationNumber;
  int vehicleStatus;
  String dateCreated;
  int locationId;
  String locationName;
  int vehicleModelId;
  String vehicleModelName;
  bool isOperational;
  int franchizeId;
  String franchiseName;
  String engineNumber;
  String chasisNumber;

  VehicleItems(
      {this.details,
        this.id,
        this.registrationNumber,
        this.vehicleStatus,
        this.dateCreated,
        this.locationId,
        this.locationName,
        this.vehicleModelId,
        this.vehicleModelName,
        this.isOperational,
        this.franchizeId,
        this.franchiseName,
        this.engineNumber,
        this.chasisNumber});

  VehicleItems.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    id = json['id'];
    registrationNumber = json['registrationNumber'];
    vehicleStatus = json['vehicleStatus'];
    dateCreated = json['dateCreated'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    vehicleModelId = json['vehicleModelId'];
    vehicleModelName = json['vehicleModelName'];
    isOperational = json['isOperational'];
    franchizeId = json['franchizeId'];
    franchiseName = json['franchiseName'];
    engineNumber = json['engineNumber'];
    chasisNumber = json['chasisNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['id'] = this.id;
    data['registrationNumber'] = this.registrationNumber;
    data['vehicleStatus'] = this.vehicleStatus;
    data['dateCreated'] = this.dateCreated;
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['vehicleModelId'] = this.vehicleModelId;
    data['vehicleModelName'] = this.vehicleModelName;
    data['isOperational'] = this.isOperational;
    data['franchizeId'] = this.franchizeId;
    data['franchiseName'] = this.franchiseName;
    data['engineNumber'] = this.engineNumber;
    data['chasisNumber'] = this.chasisNumber;
    return data;
  }
}
