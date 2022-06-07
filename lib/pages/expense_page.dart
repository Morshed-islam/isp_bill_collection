import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/tab_page/expense_entry.dart';
import 'package:isp_bill_collection/pages/tab_page/expense_list.dart';

class ExpensePage extends StatefulWidget {

  static const routeName = '/expense_page';

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Tabs Demo'),
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

//       Scaffold(
//       appBar: AppBar(
//         title: Text('খরচের তালিকা'),
//       ),
//
//       body: DefaultTabController(
//         length: 2,
//         child: TabBar(tabs: [
//           Tab(icon: Icon(Icons.add),text: 'Tab 1',),
//           Tab(icon: Icon(Icons.add),text: 'Tab 2',),
//
//         ]),
//       ),
//     );
//
//   }
// }
