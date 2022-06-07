import 'package:flutter/material.dart';
import 'package:isp_bill_collection/providers/expense_provider.dart';
import 'package:provider/provider.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({Key? key}) : super(key: key);

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {

  late ExpenseProvider _expenseprovider;
  @override
  void didChangeDependencies() {

    _expenseprovider = Provider.of<ExpenseProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE LIST'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _expenseprovider.expenseList.length,
        itemBuilder: (context, index) {
          final expense = _expenseprovider.expenseList[index];
          return Card(
            child: ListTile(
              onTap: () {

              },
              title: Text('${expense.month}'),
              trailing: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.blueGrey, spreadRadius: 5),
                  ],
                ),

              ),

            ),
            elevation: 2,
          );
        },
      ),
    );
  }
}
