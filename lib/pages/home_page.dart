import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isp_bill_collection/auth/auth_serrvice.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/billing_page.dart';
import 'package:isp_bill_collection/pages/expense_page.dart';
import 'package:isp_bill_collection/pages/login_page.dart';
import 'package:isp_bill_collection/pages/tab_page/expense_list.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late CustomerProvider _customerProvider;

  @override
  void didChangeDependencies(){

    _customerProvider = Provider.of<CustomerProvider>(context,listen: false);
    _customerProvider.getAllCustomers();

    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নেট বিল কালেকশন'),
        elevation: 2,
        flexibleSpace: Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 5),
          child: IconButton(
            padding: EdgeInsets.all(5),
            icon: Lottie.asset('images/log_out2.json'),
            onPressed:(){
              setState(() {
                AuthService.logout();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              });

            } ,
          ),
        ),
      ),
      body: DoubleBackToCloseApp(
        child: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          children: [
            //add customer
            Container(
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       offset: Offset(2, 4),
              //       blurRadius: 2,
              //       color: Color.fromRGBO(0, 0, 0, 0.16),
              //     )
              //   ]
              // ),
              child: Card(
                child: OverflowBox(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, AddCustomer.routeName);

                      });
                    },
                    splashColor: Colors.black12,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('images/add_customer1.json',
                              width: 100, height: 100, fit: BoxFit.fill),
                          Text(
                            'নতুন কাস্টমার ',
                            style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Card(
                child: OverflowBox(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, AllCustomer.routeName);
                        print('Add customer is pressed');
                      });
                    },
                    splashColor: Colors.black12,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('images/view_user.json',
                              width: 100, height: 100, fit: BoxFit.fill),
                          Text(
                            'কাস্টমার লিস্ট',
                            style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: OverflowBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, BillingPage.routeName);
                  },
                  splashColor: Colors.black12,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('images/billing.json',
                            width: 100, height: 100, fit: BoxFit.fill),
                        Text(
                          'বিল কালেকশন',
                          style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: OverflowBox(
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.black12,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('images/dues2.json',
                            width: 100, height: 100, fit: BoxFit.fill),
                        Text(
                          'বকেয়া',
                          style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: OverflowBox(
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.black12,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('images/report.json',
                            width: 100, height: 100, fit: BoxFit.fill),
                        Text(
                          'রিপোর্টস',
                          style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: OverflowBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ExpensePage.routeName);

                  },
                  splashColor: Colors.black12,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('images/expense.json',
                            width: 100, height: 100, fit: BoxFit.fill),
                        Text(
                          'খরচ',
                          style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),


    );
  }

  void _logOutUser() {

  }
}
