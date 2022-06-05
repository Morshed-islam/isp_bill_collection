import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _packageDropdownList = [
  '1Mbps',
  '2Mbps',
  '3Mbps',
  '4Mbps',
  '5Mbps',
  'Hotpost'
];
const _villageDropdownList = [
  'Jhalkhur',
  'BombuPara',
  'SatiyanPara',
  'VitaPara',
  'Apsun',
  'Saduria',
  'Bolorampur',
  'Kichok'
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
        title: Text('Add Customer'),
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
                      hintText: 'Customer Name',
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
                      hintText: 'Billing Amount',
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
                      hintText: 'Phone Number',
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
                        hint: Text('Select Village'),
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
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
