import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/pages/add_customer.dart';
import 'package:isp_bill_collection/pages/all_customer.dart';
import 'package:isp_bill_collection/pages/home_page.dart';
import 'package:isp_bill_collection/pages/launcher_page.dart';
import 'package:isp_bill_collection/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}

