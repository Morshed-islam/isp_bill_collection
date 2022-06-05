import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_bill_collection/model/Customer.dart';

class DBHelper {

  static const collectionCustomer = 'Customers';
  static const collectionBilling = 'Billings';
  static const collectionDue = 'Dues';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  // static Future<void> addNewCustomer (Customer customer){
  //
  // }

}