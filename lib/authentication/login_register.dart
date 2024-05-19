import 'package:flutter/material.dart';
import 'package:sdp4/pages/login_page.dart';
import 'package:sdp4/pages/register_page.dart';


class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLoginPage= true;

  void togglePress() {
    setState(() {
      showLoginPage= !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePress);
    } else {
      return RegisterPage(onTap: togglePress);
    }
  }
}
