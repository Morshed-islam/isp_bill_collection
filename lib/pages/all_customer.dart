import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/customer_details_page.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class AllCustomer extends StatefulWidget {
  static const String routeName = '/all_customer';

  @override
  State<AllCustomer> createState() => _AllCustomerState();
}

class _AllCustomerState extends State<AllCustomer> {
  late CustomerProvider _provider;

  @override
  void didChangeDependencies() {
    _provider = Provider.of<CustomerProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            const Text(
              'কাস্টমার লিস্ট',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  const BoxShadow(color: Colors.blueGrey, spreadRadius: 5),
                ],
              ),
              child: Text('${BanglaUtility.englishToBanglaDigit(englishDigit: _provider.getTotalCustomer)} জন',),
            ),
          ])),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _provider.customerList.length,
        itemBuilder: (context, index) {
          final customer = _provider.customerList[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, CustomerDetailPage.routeName,
                    arguments: [
                      customer.id,
                      customer.name,
                      customer.bill,
                      customer.phone,
                    ]);
              },
              title: Text(customer.name),
              trailing: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: const [
                    BoxShadow(color: Colors.blueGrey, spreadRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'প্যাকেজঃ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(customer.package,
                        style: const TextStyle(
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
