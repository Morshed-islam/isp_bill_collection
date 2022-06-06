class DueModel {
  String? due_id;
  String? customer_id;
  num due_bill;
  int? day;
  int? month;
  int? year;

  DueModel(
      {this.due_id,
      this.customer_id,
      this.due_bill=0,
      this.day,
      this.month,
      this.year});

  Map<String,dynamic> toMap () {
    var map = <String,dynamic>{
      'due_id' : due_id,
      'customer_id' : customer_id,
      'due_bill' : due_bill,
      'day' : day,
      'month' : month,
      'year' : year,
    };
    return map;
  }

  factory DueModel.fromMap(Map<String,dynamic> map) => DueModel(
    due_id: map['due_id'],
    customer_id: map['customer_id'],
    due_bill: map['due_bill'],
    day: map['day'],
    month: map['month'],
    year: map['year'],
  );


}
