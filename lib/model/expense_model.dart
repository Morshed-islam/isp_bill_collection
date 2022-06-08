import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? admin_id;
  num? expense_amount;
  String? desc;
  int? day;
  int? month;
  int? year;
  Timestamp? timestamp;

  ExpenseModel(
      {this.admin_id,
      this.expense_amount,
      this.desc,
      this.day,
      this.month,
      this.year,
      this.timestamp});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'admin_id': admin_id,
      'expense_amount': expense_amount,
      'desc': desc,
      'day': day,
      'month': month,
      'year': year,
      'timestamp': timestamp
    };
    return map;
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) => ExpenseModel(
      admin_id: map['admin_id'],
      expense_amount: map['expense_amount'],
      desc: map['desc'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      timestamp: map['timestamp']);
}
