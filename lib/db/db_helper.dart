import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_bill_collection/model/customer_model.dart';
import 'package:isp_bill_collection/model/due_model.dart';
import 'package:isp_bill_collection/model/expense_model.dart';

class DBHelper {

  static const collectionCustomer = 'Customers';
  static const collectionBilling = 'Billings';
  static const collectionDue = 'Dues';
  static const collectionExpense = 'Expenses';

  static FirebaseFirestore _db = FirebaseFirestore.instance;


  static Future<void> addNewCustomer (CustomerModel1 customerModel,DueModel dueModel){

    final writeBatch = _db.batch();
    final customerDoc = _db.collection(collectionCustomer).doc();
    final dueDoc = _db.collection(collectionDue).doc();

    customerModel.id = customerDoc.id;

    dueModel.due_id = dueDoc.id;
    dueModel.customer_id = customerDoc.id;
    
    writeBatch.set(customerDoc, customerModel.toMap());
    writeBatch.set(dueDoc, dueModel.toMap());

    return writeBatch.commit();
  }


  static Future<void> addExpenseDate (ExpenseModel expenseModel){

    final writeBatch = _db.batch();
    final expenseDoc = _db.collection(collectionExpense).doc();

    expenseModel.admin_id = expenseDoc.id;
    writeBatch.set(expenseDoc, expenseModel.toMap());

    return writeBatch.commit();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCustomers(){
    return _db.collection(collectionCustomer).snapshots();
  }


  //TODO to be continued
   static Stream<QuerySnapshot<Map<String, dynamic>>> fetchTotalDueByUserID(String userId)=>
       _db.collection(collectionDue).where('customer_id', isEqualTo: userId).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchExpenseByMonth() {
    var date =  DateTime.now();
     return _db.collection(collectionExpense)
        .where('year', isGreaterThanOrEqualTo: 2022)
        .orderBy('year', descending: true)
        .snapshots();
     //DateTime(date.year, 1)
  }


}