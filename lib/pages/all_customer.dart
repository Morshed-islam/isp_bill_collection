import 'package:flutter/material.dart';

class AllCustomer extends StatefulWidget {
  static const String routeName = '/all_customer';


  @override
  State<AllCustomer> createState() => _AllCustomerState();
}

class _AllCustomerState extends State<AllCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Customer'),
      ),
    );
  }
}
