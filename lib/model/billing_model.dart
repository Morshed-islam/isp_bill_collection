import 'package:cloud_firestore/cloud_firestore.dart';

class BillingModel {
  String? billingId;
  String? customerId;
  num billAmount;
  String? billStatus;
  Timestamp? billingTime;
  int? day;
  int? month;
  int? year;

  BillingModel(
      {this.billingId,
      this.customerId,
      this.billAmount=0,
      this.billStatus,
      this.billingTime,
      this.day,
      this.month,
      this.year});

  Map<String,dynamic> toMap () {
    var map = <String,dynamic>{
      'billingId' : billingId,
      'customerId' : customerId,
      'billAmount' : billAmount,
      'billStatus' : billStatus,
      'billingTime' : billingTime,
      'day' : day,
      'month' : month,
      'year' : year,
    };
    return map;
  }


  //to fetch data
  factory BillingModel.fromMap(Map<String,dynamic> map) => BillingModel(
    billingId: map['billingId'],
    customerId: map['customerId'],
    billAmount: map['billAmount'],
    billStatus: map['billStatus'],
    billingTime: map['billingTime'],
    day: map['day'],
    month: map['month'],
    year: map['year'],
  );

}
