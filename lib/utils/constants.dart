import 'package:flutter/material.dart';

const String emptyFieldErrMsg = ' This Field is Required';

void showMsg(BuildContext context, String msg){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));



}