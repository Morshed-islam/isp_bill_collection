import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:isp_bill_collection/auth/auth_serrvice.dart';
import 'package:isp_bill_collection/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _PasswordController = TextEditingController();
  String _errMsg = '';

  @override
  void dispose() {
    _emailController.dispose();
    _PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Image.asset(
                'images/login.jpg',
                width: double.infinity,
                height: 300,
              ),
              Card(
                elevation: 6,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'emptyFieldErrMsg';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _PasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'emptyFieldErrMsg';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: Text('LOGIN'),
                        onPressed: _loginAdmin,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(_errMsg),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _loginAdmin() async {
    if (_formkey.currentState!.validate()) {
      try {
        final uid = await AuthService.loginAdmin(
            _emailController.text, _PasswordController.text);

        if (uid != null) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errMsg = e.message!;
        });
      }
    }
  }
}
