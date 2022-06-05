import 'package:flutter/material.dart';

import 'package:isp_bill_collection/auth/auth_serrvice.dart';
import 'package:isp_bill_collection/pages/home_page.dart';
import 'package:isp_bill_collection/pages/login_page.dart';

class LauncherPage extends StatefulWidget {

  static const String routeName ='/launcher';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {

    Future.delayed(Duration.zero, (){
      if(AuthService.currentUser == null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(

        ),
      ),
    );
  }
}
