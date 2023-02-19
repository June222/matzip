import 'package:busan_univ_matzip/providers/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  static String routesName = '/email-sign-in';

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  void signInUser() async {
    await context.read<FirebaseAuthMethods>().loginWithEmail(
          email: email,
          password: password,
          context: context,
        );
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   '/',
    //   (route) => false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(EmailSignInScreen.routesName),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "email",
              fillColor: Color(0xffF5F6FA),
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: "password",
              fillColor: Color(0xffF5F6FA),
            ),
          ),
          TextButton(
            onPressed: signInUser,
            child: const Text("signIn"),
          )
        ],
      )),
    );
  }
}
