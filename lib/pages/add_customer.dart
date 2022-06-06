import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:isp_bill_collection/db/db_helper.dart';
import 'package:isp_bill_collection/model/customer_model.dart';
import 'package:isp_bill_collection/model/due_model.dart';
import 'package:isp_bill_collection/pages/home_page.dart';
import 'package:isp_bill_collection/utils/constants.dart';

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

  String? package;
  String? village;
  DateTime? dateTime;

  @override
  void dispose() {
    _nameController.dispose();
    _billController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('নতুন কাস্টমার'),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _billController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
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
                SizedBox(
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
                        hint: Text('গ্রাম সিলেক্ট করুন'),
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
                        hint: Text('প্যাকেজ সিলেক্ট করুন'),

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
                        key: _formKey,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            child: Text('এখানে ক্লিক করুন'),
                            onPressed: _showDatePickerDialog,
                          ),
                          
                          Text(dateTime == null ? 'তারিখ পাওয়া যায়নি!' : DateFormat('dd/MM/yyyy').format(dateTime!) )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),


              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child:  InkWell(
              child: Center(
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('সেভ করুন',style: TextStyle(fontSize: 17,),),
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

  _showDatePickerDialog() async{

    final _selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year-1),
        lastDate: DateTime.now()
    );

    if(_selectedDate != null){
      setState((){
        dateTime = _selectedDate;
      });
    }

  }

  _savaDateToFirebasedb() {

    if(_formKey.currentState!.validate()){

      final _customerModel = CustomerModel1(
          name: _nameController.text,
          village: village!,
          phone: _phoneController.text,
          bill: num.parse(_billController.text),
          package: package!,
          creation_date: Timestamp.fromDate(dateTime!)
      );

      final dueModel = DueModel();
      
      DBHelper.addNewCustomer(_customerModel, dueModel).then((value){
        showMsg(context, 'নতুন কাস্টমার যোগ হয়েছে!');
        Navigator.pushReplacementNamed(context, HomePage.routeName);


      }).catchError((error){
        showMsg(context, error.toString());

      });
      

    }

  }
}
