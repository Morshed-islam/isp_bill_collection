import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class CustomerDetailPage extends StatefulWidget {

  static const routeName = '/customer_detail';

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {


  //controller
  final _nameController = TextEditingController();
  final _billController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dueController = TextEditingController();


  late CustomerProvider _customerProvider;
  String? id;
  String? name;
  String? phone;
  num? bill;

  @override
  void didChangeDependencies() {
    // _customerProvider = Provider.of<CustomerProvider>(context);
    final argsList = ModalRoute.of(context)!.settings.arguments as List;
    //
    id = argsList[0];
    name = argsList[1];
    bill = argsList[2];
    phone = argsList[3];

    super.didChangeDependencies();
  }
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        
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
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(name!),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('${bill}'),
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
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('${phone}'),
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
                      'আপডেট করুন',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  onPressed: _updateDataToFirebasedb,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateDataToFirebasedb() {

  }
}
