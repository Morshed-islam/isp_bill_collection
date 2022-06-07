import 'package:flutter/material.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/customer_model.dart';
import 'package:isp_bill_collection/model/due_model.dart';

class CustomerProvider extends ChangeNotifier {
  List<CustomerModel1> customerList = [];

  Future<void> saveCustomer(CustomerModel1 customerModel1, DueModel dueModel) {
    return DBHelper.addNewCustomer(customerModel1, dueModel);
  }

  void getAllCustomers() {
    DBHelper.fetchAllCustomers().listen((event) {
      customerList = List.generate(event.docs.length,
          (index) => CustomerModel1.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}
