import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isp_bill_collection/model/billing_model.dart';
import 'package:isp_bill_collection/model/monthly_due_model.dart';
import 'package:isp_bill_collection/pages/billing_page.dart';
import 'package:isp_bill_collection/providers/billing_provider.dart';
import 'package:isp_bill_collection/providers/due_provider.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

const _paymentList = ['paid', 'due', 'বিকাশ/রকেট'];

class BillingDetailsPage extends StatefulWidget {
  static const String routeName = '/billing_details';

  @override
  State<BillingDetailsPage> createState() => _BillingDetailsPageState();
}

class _BillingDetailsPageState extends State<BillingDetailsPage> {
  late DueProvider _dueProvider;
  final _formKey = GlobalKey<FormState>();

  String? customer_id;
  String? name;

  final _paidAmountController = TextEditingController();

  String? selectedPayment;
  DateTime? dateTime;
  String? total_due;
  num? previousTotalDue;
  num? paidAmount;
  String? dueId;

  @override
  void dispose() {
    _paidAmountController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _dueProvider = Provider.of<DueProvider>(context, listen: true);
    final argsList = ModalRoute.of(context)!.settings.arguments as List;
    //
    customer_id = argsList[0];
    name = argsList[1];

    _dueProvider.getTotalDueByCustomerId(customer_id!);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        // automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: _dueProvider.duesList.length,
          itemBuilder: (context, index) {
            // print('${_dueProvider.duesList.length}');
            final dues = _dueProvider.duesList[index];
            previousTotalDue = dues.total_due_bill;
            dueId = dues.due_id;
            // setState(() async{
            //    temp = await dues.total_due_bill;
            //   print('Temp Due Data: ${_dueProvider.duesList.length}');
            // });
            // print('Temp Due Data Outside SetState: $temp');

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      child: Text(
                        'মোট বকেয়া আছে: ${dues.total_due_bill} টাকা',
                        key: ValueKey<num>(dues.total_due_bill),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: DropdownButtonFormField<String>(
                          hint: const Text('পেমেন্ট সিলেক্ট করুন'),
                          value: selectedPayment,
                          onChanged: (value) {
                            selectedPayment = value;
                          },
                          items: _paymentList
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
                  SizedBox(height: 5),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                    child: TextFormField(
                      onChanged: (s) {
                        paidAmount = num.parse(_paidAmountController.text);
                      },
                      controller: _paidAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'টাকার পরিমান',
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
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                  SizedBox(height: 5),
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
                          onPressed: _savaDateToBillingDb,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
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


  void _dbModel(BillingModel _billingModel,MonthlyDueModel _monthlyDueModel){

  }

  void _savaDateToBillingDb() async {
    if (_formKey.currentState!.validate()) {
      print('Check Statement');

      final _billingModel = BillingModel(
          customerId: customer_id,
          billAmount: num.parse(_paidAmountController.text),
          billStatus: selectedPayment.toString(),
          billingTime: Timestamp.fromDate(dateTime!),
          day: dateTime!.day,
          month: dateTime!.month,
          year: dateTime!.year);

      final _monthlyDueModel = MonthlyDueModel(
          customerId: customer_id,
          dueAmount: num.parse(_paidAmountController.text),
          dueTime: Timestamp.fromDate(dateTime!),
          duesStatus: selectedPayment.toString(),
          day: dateTime!.day,
          month: dateTime!.month,
          year: dateTime!.year);

      if (selectedPayment == 'paid') {
        if (paidAmount == previousTotalDue) {
          Provider.of<DueProvider>(context, listen: true)
              .updateDueAmountByDueId(dueId!, 0)
              .then((value) {})
              .catchError((onError) {
            showMsg(context, onError.toString());
          });

          Provider.of<BillingProvider>(context, listen: true)
              .saveBilling(customer_id!, _billingModel, _monthlyDueModel)
              .then((value) {
            showMsg(context, 'মাসিক বিল যোগ করা হয়েছে!');
            Navigator.pushReplacementNamed(context, BillingPage.routeName);
          }).catchError((onError) {
            showMsg(context, onError.toString());
          });

          print('First Statement');
          print('data saved to (Billings)');
          print('Due 0 saved to (DueByMonth) collection');
        } else if (paidAmount! > previousTotalDue!) {
          //update due amount
          Provider.of<DueProvider>(context, listen: true)
              .updateDueAmountByDueId(dueId!, 0)
              .then((value) {})
              .catchError((onError) {
            showMsg(context, onError.toString());
          });

          //save date to billings and MonthlyDues Collection
          Provider.of<BillingProvider>(context, listen: true)
              .saveBilling(customer_id!, _billingModel, _monthlyDueModel)
              .then((value) {
            showMsg(context, 'মাসিক বিল যোগ করা হয়েছে!');
            Navigator.pushReplacementNamed(context, BillingPage.routeName);
          }).catchError((onError) {
            showMsg(context, onError.toString());
          });

          print('2nd Statement');
          print('data saved to (Billings)');
          print('Due 0 saved to (DueByMonth) collection');
        } else if (paidAmount! < previousTotalDue!) {
          num _totalDueAmount = (previousTotalDue! - paidAmount!);
          //update due amount
          Provider.of<DueProvider>(context, listen: true)
              .updateDueAmountByDueId(dueId!, _totalDueAmount)
              .then((value) {})
              .catchError((onError) {
            showMsg(context, onError.toString());
          });

          //save date to billings and MonthlyDues Collection
          Provider.of<BillingProvider>(context, listen: true)
              .saveBilling(customer_id!, _billingModel, _monthlyDueModel)
              .then((value) {
            showMsg(context, 'মাসিক বিল যোগ করা হয়েছে!');
            Navigator.pushReplacementNamed(context, BillingPage.routeName);
          }).catchError((onError) {
            showMsg(context, onError.toString());
          });

          print('3rd Statement');
          print('data saved to (PaidCollection)');
          print('totalDue = previousDue - paidAmount');
        }
      } else if (selectedPayment == 'due') {
        num _totalDueAmount = paidAmount! + previousTotalDue!;

        //update due amount
        Provider.of<DueProvider>(context, listen: true)
            .updateDueAmountByDueId(dueId!, _totalDueAmount)
            .then((value) {
          showMsg(context, 'বকেয়া বিল যোগ করা হয়েছে!');
          Navigator.pushReplacementNamed(context, BillingPage.routeName);
        }).catchError((onError) {
          showMsg(context, onError.toString());
        });

        print('Total Due: $_totalDueAmount');
      }
    }
  }
}
