import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isp_bill_collection/model/expense_model.dart';
import 'package:isp_bill_collection/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ExpenseEntryPage extends StatefulWidget {
  const ExpenseEntryPage({Key? key}) : super(key: key);

  @override
  State<ExpenseEntryPage> createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState extends State<ExpenseEntryPage> {
  final _formKey = GlobalKey<FormState>();

  final _costController = TextEditingController();
  final _descController = TextEditingController();

  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _costController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'খরচের পরিমান',
                      prefixIcon: Icon(Icons.balance),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'emptyFieldErrMsg';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    maxLines: 3,
                    controller: _descController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      errorMaxLines: 2,
                      hintText: 'বিস্তারিত লিখুন',
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'emptyFieldErrMsg';
                      }
                      return null;
                    },
                  ),
                ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            child: const Text('এখানে ক্লিক করুন'),
                            onPressed: _showDatePickerDialog,
                          ),
                          Text(dateTime == null
                              ? 'তারিখ পাওয়া যায়নি!'
                              : DateFormat('dd/MM/yyyy').format(dateTime!))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: InkWell(
              child: Center(
                child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'সেভ করুন',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  onPressed: _savaDateToExpenseDb,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    final _selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());

    if (_selectedDate != null) {
      setState(() {
        dateTime = _selectedDate;
      });
    }
  }

  void _savaDateToExpenseDb() {
    if (_formKey.currentState!.validate()) {
      final _expenseModel = ExpenseModel(
          expense_amount: num.parse(_costController.text),
          desc: _descController.text,
          day: dateTime!.day,
          month: dateTime!.month,
          year: dateTime!.year,
          timestamp: Timestamp.fromDate(dateTime!));

      Provider.of<ExpenseProvider>(context, listen: false)
          .saveExpenseData(_expenseModel)
          .then((value) {
        showMsg(context, 'খরচ যোগ হয়েছে!');
        _costController.clear();
        _descController.clear();
        dateTime = null;
      }).catchError((error) {
        showMsg(context, error.toString());
      });
    }
  }
}
