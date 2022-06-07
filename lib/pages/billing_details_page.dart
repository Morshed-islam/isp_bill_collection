import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/providers/billing_provider.dart';
import 'package:isp_bill_collection/providers/due_provider.dart';
import 'package:provider/provider.dart';

class BillingDetailsPage extends StatefulWidget {

  static const String routeName = '/billing_details';


  @override
  State<BillingDetailsPage> createState() => _BillingDetailsPageState();
}

class _BillingDetailsPageState extends State<BillingDetailsPage> {

  late DueProvider _dueProvider;

  String? customer_id;
  String? name;

  @override
  void didChangeDependencies() {
    _dueProvider = Provider.of<DueProvider>(context,listen: true);
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
      ),
      body: ListView.builder(
        itemCount: _dueProvider.duesList.length,
          itemBuilder: (context,index){
          print('Hello here ${ _dueProvider.duesList.length}');
          final dues = _dueProvider.duesList[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,

            child: Text('মোট বকেয়া আছে: ${dues.total_due_bill} টাকা',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
            ),
          );

          }),
    );
  }
}
