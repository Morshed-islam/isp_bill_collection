import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyDueModel{
  String? dueId;
  String? customerId;
  num? dueAmount;
  Timestamp? dueTime;
  String? duesStatus;
  int? day;
  int? month;
  int? year;

  MonthlyDueModel(
      {this.dueId,
      this.customerId,
      this.dueAmount,
      this.dueTime,
      this.duesStatus,
      this.day,
      this.month,
      this.year});

  Map<String,dynamic> toMap () {
    var map = <String,dynamic>{
      'dueId' : dueId,
      'customerId' : customerId,
      'dueAmount' : dueAmount,
      'dueTime' : dueTime,
      'duesStatus' : duesStatus,
      'day' : day,
      'month' : month,
      'year' : year,
    };
    return map;
  }


  //to fetch data
  factory MonthlyDueModel.fromMap(Map<String,dynamic> map) => MonthlyDueModel(
    dueId: map['dueId'],
    customerId: map['customerId'],
    dueAmount: map['dueAmount'],
    dueTime: map['dueTime'],
    duesStatus: map['duesStatus'],
    day: map['day'],
    month: map['month'],
    year: map['year'],
  );
}