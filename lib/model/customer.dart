class CustomerModel {
  String? id;
  String name;
  String village;
  String? phone;
  num bill;
  String? image;
  String package;

  CustomerModel(
      {this.id,
      required this.name,
      required this.village,
      this.phone,
      required this.bill,
      this.image,
      required this.package});

  Map<String,dynamic> toMap () {
    var map = <String,dynamic>{
      'id' : id,
      'name' : name,
      'village' : village,
      'phone' : phone,
      'bill' : bill,
      'image' : image,
      'package' : package,
    };
    return map;
  }


  factory CustomerModel.fromMap(Map<String,dynamic> map) => CustomerModel(
      id: map['id'],
      name: map['name'],
      village: map['village'],
      phone: map['phone'],
      bill: map['bill'],
      image: map['image'],
      package: map['package']);


}
