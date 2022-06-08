import 'package:flutter/material.dart';
import 'package:isp_bill_collection/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../db/db_helper.dart';
import '../../utils/constants.dart';

final _dropDownList = [
  'This Month',
  'Last Month',
  'This Year',
];

class ExpenseListPage extends StatefulWidget {
  static const routeName = '/expense_list';

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  late ExpenseProvider _expenseprovider;

  num? sumOfExpense;

  @override
  void didChangeDependencies() {

    List months =
    ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];
    // var now = new DateTime.now().month;
    // current_mon = now.month;
    // print(months[current_mon-1]);
    // var prevMonth = new DateTime(date.year, date.month - 1, date.day);

    _expenseprovider = Provider.of<ExpenseProvider>(context, listen: true);
    _expenseprovider.getAllExpenseByMonth();



    super.didChangeDependencies();
  }

  String? selectedListValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Total Due: ',style: TextStyle(
          color: Colors.red
        ),),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _expenseprovider.expenseList.length,
        itemBuilder: (context, index) {


          final expense = _expenseprovider.expenseList[index];

          //  sumOfExpense =0;
          // for(int i=0; i <_expenseprovider.expenseList.length; i++){
          //   sumOfExpense = expense.expense_amount! + sumOfExpense!;
          //   print(sumOfExpense);
          // }
          // _expenseprovider.expenseList.forEach((element) {
          //   sumOfExpense = element.expense_amount! + sumOfExpense!;
          // });


          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: Card(
              //     elevation: 4,
              //     child: Container(
              //       padding: const EdgeInsets.only(left: 10),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(1.0),
              //       ),
              //       child: DropdownButtonFormField<String>(
              //         hint: const Text('Filter your data'),
              //         value: selectedListValue,
              //         onChanged: (value) {
              //           selectedListValue = value;
              //           _filterdata();
              //         },
              //
              //         items: _dropDownList
              //             .map((e) => DropdownMenuItem(
              //                   child: (Text(e)),
              //                   value: e,
              //                 ))
              //             .toList(),
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Error....';
              //           }
              //           return null;
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () {},
                      title: Text('বিস্তারিত: ${expense.desc}'),
                      trailing: Text('টাকা:\n${expense.expense_amount}'),
                      subtitle:
                          Text('তারিখ: 0${expense.day}/0${expense.month}/${expense.year}'),
                    ),
                  ],
                ),
                elevation: 2,
              ),
            ],
          );
        },
      ),
    );
  }

  void _filterdata() {

    if(selectedListValue == 'This Month'){


      print(selectedListValue.toString());
      print(_expenseprovider.expenseList[0]);

    }else if(selectedListValue == 'This Year'){
      print(selectedListValue.toString());

    }else if(selectedListValue == 'Last Month'){
      print(selectedListValue.toString());

    }


  }
}
