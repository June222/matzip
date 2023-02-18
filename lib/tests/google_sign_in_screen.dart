import 'package:flutter/material.dart';

class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({super.key});
  static String routesName = "/google-sign-in";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("google-sign-in"),
    );
  }
}
