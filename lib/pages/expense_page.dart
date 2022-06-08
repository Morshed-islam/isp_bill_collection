import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/tab_page/expense_entry.dart';
import 'package:isp_bill_collection/pages/tab_page/expense_list.dart';
import 'package:isp_bill_collection/providers/expense_provider.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {

  static const routeName = '/expense_page';


  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {


  @override
  void didChangeDependencies(){

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('খরচের হিসেব'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add), text: "খরচ লিখুন"),
                Tab(icon: Icon(Icons.balance), text: "খরচের লিস্ট")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ExpenseEntryPage(),
              ExpenseListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

