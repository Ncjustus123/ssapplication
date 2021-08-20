import 'getClaimsModel.dart';

class ProfileModel {
  String code;
  String shortDescription;
  ProfileModelObject object;

  ProfileModel({this.code, this.shortDescription, this.object});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
    json['object'] != null ? new ProfileModelObject.fromJson(json['object']) : null;
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

class ProfileModelObject {
  String nextOfKin;
  String nextOfKinPhone;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String gender;
  String address;
  String middleName;
  String dateJoined;
  int userType;
  int companyId;
  List<ClaimsObject> claimsObject;


  ProfileModelObject(
      {this.nextOfKin,
        this.nextOfKinPhone,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.gender,
        this.address,
        this.middleName,
        this.dateJoined,
        this.userType,
        this.companyId,
        this.claimsObject});

  ProfileModelObject.fromJson(Map<String, dynamic> json) {
    nextOfKin = json['nextOfKin'];
    nextOfKinPhone = json['nextOfKinPhone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    address = json['address'];
    middleName = json['middleName'];
    dateJoined = json['dateJoined'];
    userType = json['userType'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextOfKin'] = this.nextOfKin;
    data['nextOfKinPhone'] = this.nextOfKinPhone;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['middleName'] = this.middleName;
    data['dateJoined'] = this.dateJoined;
    data['userType'] = this.userType;
    data['companyId'] = this.companyId;
    return data;
  }
}
