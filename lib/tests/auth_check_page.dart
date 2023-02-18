import 'package:busan_univ_matzip/providers/services/firebase_auth_methods.dart';
import 'package:busan_univ_matzip/tests/email_sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const TestHomePage();
    } else {
      return const TestLoginScreen();
    }
  }
}

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  static String routesName = "/homepage";

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const Text("TestHomePage"),
        if (!context.read<FirebaseAuthMethods>().user.emailVerified)
          TextButton(
              onPressed: () => setState(() {}),
              child: const Text("인증을 한 뒤에 눌러주세요.")),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
          text: "sign Out",
        )
      ],
    )));
  }
}

class TestLoginScreen extends StatelessWidget {
  const TestLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailSignInScreen.routesName);
              },
              text: "Email-Sign-In",
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailSignUpScreen.routesName);
              },
              text: "Email-Sign-Up",
            ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signInWithGoogle(context);
              },
              text: 'Google Sign In',
            ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signInAnonymously(context);
              },
              text: '익명 Sign In',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});
  static String routesName = "/email-sign-up";

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  void signUpUser() async {
    await context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: email,
          password: password,
          context: context,
        );
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(EmailSignUpScreen.routesName),
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
              onPressed: signUpUser,
              child: const Text("signup"),
            )
          ],
        ),
      ),
    );
  }
}
