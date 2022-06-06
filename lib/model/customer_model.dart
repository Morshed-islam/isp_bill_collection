import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel1 {
  String? id;
  String name;
  String village;
  String? phone;
  num bill;
  String? image;
  String package;
  Timestamp? creation_date;

  CustomerModel1(
      {this.id,
        required this.name,
        required this.village,
        this.phone,
        required this.bill,
        this.image,
        required this.package,
        this.creation_date
      });

  Map<String,dynamic> toMap () {
    var map = <String,dynamic>{
      'id' : id,
      'name' : name,
      'village' : village,
      'phone' : phone,
      'bill' : bill,
      'image' : image,
      'package' : package,
      'timestamp' : creation_date,
    };
    return map;
  }


  factory CustomerModel1.fromMap(Map<String,dynamic> map) => CustomerModel1(
    id: map['id'],
    name: map['name'],
    village: map['village'],
    phone: map['phone'],
    bill: map['bill'],
    image: map['image'],
    package: map['package'],
    creation_date: map['timestamp'],
  );


}