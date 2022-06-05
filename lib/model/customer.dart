class Customer {
  String? id;
  String name;
  String village;
  String? phone;
  num bill;
  String? image;
  String package;

  Customer(
      {this.id,
      required this.name,
      required this.village,
      this.phone,
      required this.bill,
      this.image,
      required this.package});
}
