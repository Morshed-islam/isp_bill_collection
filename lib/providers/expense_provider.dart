import 'package:flutter/foundation.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/expense_model.dart';

class ExpenseProvider extends ChangeNotifier{

  Future<void> saveExpenseData(ExpenseModel expenseModel){
    return DBHelper.addExpenseDate(expenseModel);

  }


}