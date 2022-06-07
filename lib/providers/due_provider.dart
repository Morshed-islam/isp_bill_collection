import 'package:flutter/material.dart';
import 'package:isp_bill_collection/model/due_model.dart';

import '../db/db_helper.dart';

class DueProvider extends ChangeNotifier{

  List<DueModel> duesList = [];

  void getTotalDueByCustomerId(String customerId) async {
    DBHelper.fetchTotalDueByUserID(customerId).listen((event) {
      duesList = List.generate(event.docs.length, (index) => DueModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  // void getTotalDueByCustomerId() async {
  //   DBHelper.fetchTotalDueByUserID().listen((event) {
  //     duesList = List.generate(event.docs.length, (index) => DueModel.fromMap(event.docs[index].data()));
  //     notifyListeners();
  //   });

  }

}