import 'package:driver_salary/api_response.dart';

class WalletDetails implements BluePrint {
  WalletDetails(
      {this.customerId,
      this.ledgerBalance,
      this.availableBalance,
      this.blockedBalance,
      this.phoneNumber,
      this.fullName,
      this.id});

  factory WalletDetails.fromJson(Map json) {
    return WalletDetails(
        id: json['id'],
        phoneNumber: json['phoneNumber'],
        availableBalance: json['availableBalance'],
        blockedBalance: json['blockedBalance'],
        customerId: json['customerId'],
        fullName: json['fullName'],
        ledgerBalance: json['ledgerBalance']);
  }

  final String customerId;
  final double ledgerBalance;
  final dynamic availableBalance;
  final double blockedBalance;
  final String phoneNumber;
  final String fullName;
  final String id;

  @override
  WalletDetails fromJSON(json) {
    return WalletDetails.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['id'] = id;
    json['phoneNumber'] = phoneNumber;
    json['availableBalance'] = availableBalance;
    json['blockedBalance'] = blockedBalance;
    json['customerId'] = customerId;
    json['fullName'] = fullName;
    json['ledgerBalance'] = ledgerBalance;
    return json;
  }
}

class CreateWalletRequest implements BluePrint<CreateWalletRequest> {
  CreateWalletRequest({this.userId, this.phoneNumber});

  factory CreateWalletRequest.fromJson(Map json) {
    return CreateWalletRequest(
        phoneNumber: json['phoneNumber'], userId: json['userId']);
  }

  final String userId;
  final String phoneNumber;

  @override
  CreateWalletRequest fromJSON(json) {
    return CreateWalletRequest.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['phoneNumber'] = phoneNumber;
    json['userId'] = userId;
    return json;
  }
}

class TransactionObject implements BluePrint<TransactionObject> {
  TransactionObject(
      {this.reference,
      this.transactionAmount,
      this.walletId,
      this.transDescription,
      this.transactionType,
      this.transactionDate,
      this.id});

  factory TransactionObject.fromJson(Map json) {
    return TransactionObject(
        id: json['id'],
        transactionAmount: json['transactionAmount'],
        transactionDate: json['transactionDate'],
        reference: json['reference'],
        transDescription: json['transDescription'],
        transactionType: json['transactionType'],
        walletId: json['walletId']);
  }

  final String reference;
  final double transactionAmount;
  final int walletId;
  final String transDescription;
  final int transactionType;
  final String transactionDate;
  final String id;

//  "transactionType": 0,
//  "transType": "Debit",
//  "transactionSourceId": "00000000-0000-0000-0000-000000000000",
//  "transactionAmount": 1000,
//  "transactionDate": "2020-01-01T00:00:00",
//  "lineBalance": 0,
//  "walletId": 0,
//  "transDescription": "testm",
//  "payTypeDes": "MTU",

  @override
  TransactionObject fromJSON(json) {
    return TransactionObject.fromJson(json);
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['id'] = id;
    json['transactionAmount'] = transactionAmount;
    json['transactionDate'] = transactionDate;
    json['reference'] = reference;
    json['transDescription'] = transDescription;
    json['transactionType'] = transactionType;
    json['walletId'] = walletId;
    return json;
  }
}

class WalletTransactions implements BluePrint<WalletTransactions> {
  WalletTransactions();

  factory WalletTransactions.fromList(List<TransactionObject> list) {
    WalletTransactions w = WalletTransactions();
    w.list.addAll(list);
    return w;
  }
  final List<TransactionObject> list = List();

  @override
  WalletTransactions fromJSON(dynamic json) {
    List<TransactionObject> nList = List();
    for (int i = 0; i < json.length; i++) {
      nList.add(TransactionObject.fromJson(json[i]));
    }
    return WalletTransactions.fromList(nList);
  }

  @override
  Map toJSON() {
    Map json = Map();
    for (int i = 0; i < list.length; i++) {
      json[i] = list[i].toJSON();
    }
    return json;
  }

  List<TransactionObject> getTransactions(int type) {
    List<TransactionObject> list = List();
    for (TransactionObject t in this.list) {
      if (t.transactionType == type) list.add(t);
    }
    return list;
  }

  double getBalance(int type) {
    double total = 0;
    for (TransactionObject t in this.list) {
      if (t.transactionType == type) total += t.transactionAmount;
    }
    return total;
  }
}

class ReportRequest implements BluePrint {
  final String startDate;
  final String endDate;
  final String code;

  ReportRequest({this.startDate, this.endDate, this.code});

  @override
  fromJSON(json) {
    // TODO: implement fromJSON
    return null;
  }

  @override
  Map toJSON() {
    Map json = Map();
    json['startDate'] = startDate;
    json['endDate'] = endDate;
    json['code'] = code;

    // TODO: implement toJSON
    return json;
  }
}
