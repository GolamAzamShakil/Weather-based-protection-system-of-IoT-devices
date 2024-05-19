import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sdp4/authentication/login_register.dart';
import 'package:sdp4/pages/home_page.dart';

class LoginVerify extends StatelessWidget {
  const LoginVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginRegister();
          }
        },
      ),
    );
  }
}
