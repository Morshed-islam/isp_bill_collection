import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCustomer extends StatefulWidget {
  static const String routeName = '/add_customer';

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {

  final _formKey = GlobalKey<FormState>();



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
                SizedBox(height: 10,),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Customer Name'
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Billing amount'
                    ),
                  ),
                ),


                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone Number'
                    ),
                  ),
                ),


                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey
                      ),
                      child: SizedBox(height: 200,width: double.infinity,),
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
