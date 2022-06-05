import 'package:flutter/material.dart';
import 'package:isp_bill_collection/auth/auth_serrvice.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/login_page.dart';
import 'package:lottie/lottie.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISP Billing Collection'),
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
      body: GridView.count(
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
                      print('Add customer is pressed');
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
                          'Add Customer',
                          style: TextStyle(fontSize: 17.0),
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
                          'All Customer',
                          style: TextStyle(fontSize: 17.0),
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
                onTap: () {},
                splashColor: Colors.black12,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('images/billing.json',
                          width: 100, height: 100, fit: BoxFit.fill),
                      Text(
                        'Billing',
                        style: TextStyle(fontSize: 17.0),
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
                        'Dues',
                        style: TextStyle(fontSize: 17.0),
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
                        'Reports',
                        style: TextStyle(fontSize: 17.0),
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
                      Lottie.asset('images/expense.json',
                          width: 100, height: 100, fit: BoxFit.fill),
                      Text(
                        'Expense',
                        style: TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logOutUser() {

  }
}
