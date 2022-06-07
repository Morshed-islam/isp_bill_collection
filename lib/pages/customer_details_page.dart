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


  late CustomerProvider _customerProvider;
  String? id;
  String? name;

  @override
  void didChangeDependencies() {
    // _customerProvider = Provider.of<CustomerProvider>(context);
    final argsList = ModalRoute.of(context)!.settings.arguments as List;
    //
    id = argsList[0];
    name = argsList[1];

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        
      ),
      body: Container(
        child: Text(id!),
      ),
    );
  }
}
