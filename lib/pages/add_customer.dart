import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/customer_model.dart';
import 'package:isp_bill_collection/model/due_model.dart';
import 'package:isp_bill_collection/pages/home_page.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:isp_bill_collection/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

const _packageDropdownList = [
  '১ Mbps',
  '২ Mbps',
  '৩ Mbps',
  '৪ Mbps',
  '৫ Mbps',
  'হটস্পট'
];
const _villageDropdownList = [
  'ঝালখুর',
  'বম্বুপাড়া',
  'ছাতিয়ানপাড়া',
  'ভিটাপাড়া ',
  'আপসুন ',
  'সাদুরিয়া',
  'বলরাম্পুর',
  'কিচক'
];

class AddCustomer extends StatefulWidget {
  static const String routeName = '/add_customer';

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _billController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dueController = TextEditingController();

  String? package;
  String? village;
  DateTime? dateTime;

  @override
  void dispose() {
    _nameController.dispose();
    _billController.dispose();
    _phoneController.dispose();
    _dueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন কাস্টমার'),
      ),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'কাস্টমারের নাম',
                      prefixIcon: Icon(Icons.verified_user),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _billController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'মাসিক বিল',
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _dueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'বকেয়া বিল (যদি বকেয়া থাকে)',
                      prefixIcon: Icon(Icons.balance),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'মোবাইল নং',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'emptyFieldErrMsg';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      child: DropdownButtonFormField<String>(
                        hint: const Text('গ্রাম সিলেক্ট করুন'),
                        value: village,
                        onChanged: (value) {
                          village = value;
                        },
                        items: _villageDropdownList
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
                        hint: const Text('প্যাকেজ সিলেক্ট করুন'),
                        value: package,
                        onChanged: (value) {
                          package = value;
                        },
                        items: _packageDropdownList
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

                // Expanded(
                //   child: TextFormField(
                //     controller: _billController,
                //     keyboardType: TextInputType.number,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       hintText: 'মাসিক বিল',
                //       prefixIcon: Icon(Icons.balance),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'emptyFieldErrMsg';
                //       }
                //       return null;
                //     },
                //   ),
                // ),




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
                  onPressed: _savaDateToFirebasedb,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDatePickerDialog() async {
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

  _savaDateToFirebasedb() {
    print("Enter the Firebase method");
    if (_formKey.currentState!.validate()) {
      final _customerModel = CustomerModel1(
          name: _nameController.text,
          village: village!,
          phone: _phoneController.text,
          bill: num.parse(_billController.text),
          package: package!,
          creation_date: Timestamp.fromDate(dateTime!));


      final dueModel = DueModel(total_due_bill: num.parse(_dueController.text),);

      Provider.of<CustomerProvider>(context,listen: false)
                .saveCustomer(_customerModel, dueModel)
          .then((value) {
        showMsg(context, 'নতুন কাস্টমার যোগ হয়েছে!');

        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }).catchError((error) {
        showMsg(context, error.toString());
      });
    }
  }
}
