class APIResponse<T> {
  APIResponse(
      {this.payload,
      this.totalCount,
      this.responseCode,
      this.code,
      this.description,
      this.hasErrors,
      this.statusCode,
      this.raw,
      this.errors});

  T payload;
  int totalCount;
  String responseCode;
  String code;
  String description;
  bool hasErrors;
  int statusCode;
  String raw;
  List<dynamic> errors;

  Map toJson() {
    Map json = Map();
    json['hasError'] = hasErrors;
    json['totalCount'] = totalCount;
    json['code'] = code;
    json['shortDescription'] = description;
    json['object'] = (T as BluePrint).toJSON();
    json['code'] = statusCode;
    json['raw'] = raw;
    json['error'] = errors;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

abstract class BluePrint<T> {
  const BluePrint();

  T fromJSON(dynamic json);

  Map toJSON();
}
