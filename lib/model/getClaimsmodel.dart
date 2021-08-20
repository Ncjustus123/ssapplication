class ClaimsModel {
  String code;
  String shortDescription;
  List<ClaimsObject> object;

  ClaimsModel({this.code, this.shortDescription, this.object});

  ClaimsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    if (json['object'] != null) {
      object = new List<ClaimsObject>();
      json['object'].forEach((v) {
        object.add(new ClaimsObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimsObject {
  String value;

  ClaimsObject({this.value});

  ClaimsObject.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
  static Map<String, dynamic> toMap(ClaimsObject obj) => {'value': obj.value};


}
