import 'package:flutter/foundation.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/expense_model.dart';

class ExpenseProvider extends ChangeNotifier{

  late List<ExpenseModel> expenseList = [];

  Future<void> saveExpenseData(ExpenseModel expenseModel){
    return DBHelper.addExpenseData(expenseModel);

  }

  void getAllExpenseByMonth(){
    DBHelper.fetchExpenseByMonth().listen((event) {
      expenseList = List.generate(event.docs.length, (index) => ExpenseModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

}