import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_bill_collection/model/billing_model.dart';
import 'package:isp_bill_collection/model/customer_model.dart';
import 'package:isp_bill_collection/model/due_model.dart';
import 'package:isp_bill_collection/model/expense_model.dart';
import 'package:isp_bill_collection/model/monthly_due_model.dart';

class DBHelper {

  static const collectionCustomer = 'Customers';
  static const collectionBilling = 'Billings';
  static const collectionDue = 'Dues';
  static const collectionMonthlyDue = 'MonthlyDues';
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


  static Future<void> addExpenseData (ExpenseModel expenseModel){

    final writeBatch = _db.batch();
    final expenseDoc = _db.collection(collectionExpense).doc();

    expenseModel.admin_id = expenseDoc.id;
    writeBatch.set(expenseDoc, expenseModel.toMap());

    return writeBatch.commit();
  }

  static Future<void> addBillingToDb (String customerId,BillingModel billingModel,MonthlyDueModel monthlyDueModel){

    final writeBatch = _db.batch();
    final billingDoc = _db.collection(collectionBilling).doc();
    final dueDoc = _db.collection(collectionMonthlyDue).doc();

    billingModel.billingId = billingDoc.id;
    billingModel.customerId = customerId;

    monthlyDueModel.dueId = dueDoc.id;
    monthlyDueModel.customerId = customerId;

    writeBatch.set(billingDoc, billingModel.toMap());
    writeBatch.set(dueDoc, monthlyDueModel.toMap());

    return writeBatch.commit();
  }

  //TODO------------------
  static Future<void> updateDueValue(String dueId,num dueAmount) {
    return _db.collection(collectionDue).doc(dueId).update({
      'due_bill' : dueAmount,
    });
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCustomers(){
    return _db.collection(collectionCustomer).snapshots();
  }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> fetchTotalDueByUserID()=>
  //     _db.collection(collectionDue).snapshots();

   static Stream<QuerySnapshot<Map<String, dynamic>>> fetchTotalDueByUserID(String customerId)=>
       _db.collection(collectionDue).where('customer_id', isEqualTo: customerId).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchDueID(String dueId)=>
      _db.collection(collectionDue).where('due_id', isEqualTo: dueId).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchExpenseByMonth() {
    var date =  DateTime.now();
     return _db.collection(collectionExpense)
        .where('month', isEqualTo: DateTime.now().month)
         .where('year',isEqualTo: DateTime.now().year)
        .snapshots();
     //DateTime(date.year, 1)


  }




}