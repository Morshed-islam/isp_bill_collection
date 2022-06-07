import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/billing_details_page.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class BillingPage extends StatefulWidget {
  static const String routeName = '/billing_page';


  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {

  late CustomerProvider _customerProvider;

  @override
  void didChangeDependencies(){
    _customerProvider  = Provider.of<CustomerProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemCount: _customerProvider.customerList.length,
        itemBuilder: (context, index) {
          final customer = _customerProvider.customerList[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, BillingDetailsPage.routeName,
                    arguments: [
                      customer.id,
                      customer.name,
                    ]);
              },
              title: Text(customer.name),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.blueGrey, spreadRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'মাসিক বিল:',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text('Tk ${customer.bill}',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
              subtitle: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(5),
                //   boxShadow: [
                //     BoxShadow(color: Colors.blueGrey, spreadRadius: 5),
                //   ],
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('গ্রামঃ ${customer.village}'),
                    Text('ফোনঃ ${customer.phone}'),
                  ],
                ),
              ),

              //      Text('গ্রামঃ ${customer.village}
            ),
            elevation: 2,
          );
        },
      ),
    );
  }
}
