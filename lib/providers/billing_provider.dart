import 'package:flutter/foundation.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/billing_model.dart';
import 'package:isp_bill_collection/model/monthly_due_model.dart';

import '../model/due_model.dart';

class BillingProvider extends ChangeNotifier{


  Future<void> saveBilling(String customerId,BillingModel billingModel,MonthlyDueModel monthlyDueModel) {
    return DBHelper.addBillingToDb(customerId, billingModel,monthlyDueModel);

  }


}