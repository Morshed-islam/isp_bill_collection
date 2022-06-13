import 'package:flutter/foundation.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {

  late List<ExpenseModel> expenseList = [];

  Future<void> saveExpenseData(ExpenseModel expenseModel) {
    return DBHelper.addExpenseData(expenseModel);
  }

  void getAllExpenseByMonth() {
    DBHelper.fetchExpenseByMonth().listen((event) {
      expenseList = List.generate(event.docs.length, (index) =>
          ExpenseModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllExpenseByLastMonth() {
    DBHelper.fetchExpenseByLastMonth().listen((event) {
      expenseList = List.generate(event.docs.length, (index) =>
          ExpenseModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllExpenseByThisYear() {
    DBHelper.fetchExpenseByThisYear().listen((event) {
      expenseList = List.generate(event.docs.length, (index) =>
          ExpenseModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }


  num get getTotalExpenseAmount{
    num total = 0;
    expenseList.forEach((element) {
      total += element.expense_amount!;
    });
    return total;
  }

}