import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/bill_collection_page.dart';
import 'package:isp_bill_collection/pages/billing_details_page.dart';
import 'package:isp_bill_collection/pages/billing_page.dart';
import 'package:isp_bill_collection/pages/customer_details_page.dart';
import 'package:isp_bill_collection/pages/expense_page.dart';
import 'package:isp_bill_collection/pages/home_page.dart';
import 'package:isp_bill_collection/pages/launcher_page.dart';
import 'package:isp_bill_collection/pages/login_page.dart';
import 'package:isp_bill_collection/providers/billing_provider.dart';
import 'package:isp_bill_collection/providers/customer_provider.dart';
import 'package:isp_bill_collection/providers/due_provider.dart';
import 'package:provider/provider.dart';

import 'providers/expense_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context)=> DueProvider()),
        ChangeNotifierProvider(create: (context)=> ExpenseProvider()),


      ],
      child: MaterialApp(
        title: 'ISP Billing Collection',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName : (context) => LauncherPage(),
          LoginPage.routeName : (context) => LoginPage(),
          HomePage.routeName : (context) => HomePage(),
          AddCustomer.routeName : (context) => AddCustomer(),
          AllCustomer.routeName : (context) => AllCustomer(),
          CustomerDetailPage.routeName : (context) => CustomerDetailPage(),
          BillCollectionPage.routeName : (context) => BillCollectionPage(),
          ExpensePage.routeName : (context) => ExpensePage(),
          BillingPage.routeName : (context) => BillingPage(),
          BillingDetailsPage.routeName : (context) => BillingDetailsPage(),
        },
      ),
    );
  }
}

