import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../db/db_helper.dart';
import '../../utils/constants.dart';

final _dropDownList = [
  'এই মাসের খরচ',
  'গত মাসের খরচ',
  'এই বছরের খরচ',
];

class ExpenseListPage extends StatefulWidget {
  static const routeName = '/expense_list';

  const ExpenseListPage({Key? key}) : super(key: key);


  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  late ExpenseProvider _expenseprovider;

  num? sumOfExpense;
  bool pressAttention = true;

  @override
  void didChangeDependencies() {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    // var now = new DateTime.now().month;
    // current_mon = now.month;
    // print(months[current_mon-1]);
    // var prevMonth = new DateTime(date.year, date.month - 1, date.day);
    setState(() {
      _expenseprovider = Provider.of<ExpenseProvider>(
        context,
      );
    });
    // _expenseprovider.getAllExpenseByMonth();

    super.didChangeDependencies();
  }

  String? selectedListValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set this height
        child: Container(
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: const Text('সিলেক্ট করুন'),
                        value: selectedListValue,
                        isExpanded: true,
                        onChanged: (value) {
                          selectedListValue = value;
                          print('Onchanged');
                          if (selectedListValue == 'এই মাসের খরচ') {
                            _getThisMonthValue();
                          } else if (selectedListValue == 'গত মাসের খরচ') {
                            _getLastMonthValue();
                          } else {
                            _getLastYearValue();
                          }
                        },
                        items: _dropDownList
                            .map((e) => DropdownMenuItem(
                                  child: (Text(e)),
                                  value: e,
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Error....';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Text(
                    'মোট খরচঃ ${BanglaUtility.englishToBanglaDigit(englishDigit: _expenseprovider.getTotalExpenseAmount.toInt())} টাকা',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),

                // Text(' ${selectedListValue == null? 'কোনো খরচ নেই' : '${selectedListValue.toString()} ${_expenseprovider.getTotalDueAmount} টাকা' }',style: const TextStyle(
                //   fontSize: 22,
                //   color: Colors.red,
                //   fontWeight: FontWeight.bold
                // )),
              ],
            ),
          ),
        ),
      ),


      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _expenseprovider.expenseList.length,
        itemBuilder: (context, index) {
          final expense = _expenseprovider.expenseList[index];

          // totalExp = _expenseprovider.getTotalDueAmount;

          return Column(
            children: [
              //
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () {},
                      title: Text('বিস্তারিত: ${expense.desc}'),
                      trailing: Text(
                          'টাকা:\n${BanglaUtility.englishToBanglaDigit(englishDigit: expense.expense_amount!.toInt())}'),
                      subtitle: Text(
                          'তারিখ: ০${BanglaUtility.englishToBanglaDigit(englishDigit: expense.day!.toInt())}/০${BanglaUtility.englishToBanglaDigit(englishDigit: expense.month!.toInt())}/${BanglaUtility.englishToBanglaDigit(englishDigit: expense.year!.toInt())}'),
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

  void _getThisMonthValue() {
    setState(() {
      print('this month');

      _expenseprovider.getAllExpenseByMonth();
      print(_expenseprovider.getTotalExpenseAmount);
    });
  }

  void _getLastMonthValue() {
    print('last month');
    setState(() {
      _expenseprovider.getAllExpenseByLastMonth();
      print(_expenseprovider.getTotalExpenseAmount);
    });
  }

  void _getLastYearValue() {
    setState(() {
      print('this year');

      _expenseprovider.getAllExpenseByThisYear();
      print(_expenseprovider.getTotalExpenseAmount);
    });
  }
}
