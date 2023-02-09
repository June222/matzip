import 'package:busan_univ_matzip/screen/login_screen.dart';
import 'package:busan_univ_matzip/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onToggle: togglePage,
      );
    } else {
      return SignUpScreen(
        onToggle: togglePage,
      );
    }
  }
}
