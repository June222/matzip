import 'dart:developer';

import 'package:busan_univ_matzip/providers/services/firebase_auth_methods.dart';
import 'package:busan_univ_matzip/tests/email_sign_in_screen.dart';
import 'package:busan_univ_matzip/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      if (!firebaseUser.emailVerified) {
        return const EmailVerfiedScreen();
      }
      return const TestHomePage();
    } else {
      return const TestLoginScreen();
    }
  }
}

class EmailVerfiedScreen extends StatefulWidget {
  const EmailVerfiedScreen({super.key});

  @override
  State<EmailVerfiedScreen> createState() => _EmailVerfiedScreenState();
}

class _EmailVerfiedScreenState extends State<EmailVerfiedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "emailVeified-Screen",
              textAlign: TextAlign.center,
            ),
            Text("${user.email}"),
            Text("${user.emailVerified}"),
            TextButton(
                onPressed: () {
                  // user.reload();
                  log("$user");
                  bool emailVerfied = user.emailVerified;
                  // setState(() {});
                  log("$emailVerfied");
                  if (emailVerfied) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  } else {
                    showSnackBar("아직 인증이 되지 않았어요.", context);
                  }
                },
                child: const Text("인증을 한 뒤에 눌러주세요.")),
            TextButton(
                onPressed: () {
                  context
                      .read<FirebaseAuthMethods>()
                      .sendEmailVerification(context);
                },
                child: const Text("다시 보내기")),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().deleteAccount(context);
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              text: "다른 방법으로 로그인 하기",
            ),
          ],
        ),
      ),
    );
  }
}

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  static String routesName = "/homepage";

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  final TextEditingController _controller = TextEditingController();
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'https://busan-matzip.firebaseapp.com/',
    // url: 'https://matzip.page.link/',
    // This must be true
    handleCodeInApp: true,
    iOSBundleId: 'com.example.busanUnivMatzip',
    androidPackageName: 'com.example.busan_univ_matzip',
    // installIfNotAvailable
    androidInstallApp: true,

    // minimumVersion
    androidMinimumVersion: '12',
    // dynamicLinkDomain: 'https://matzip.page.link/H3Ed',
  );
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const Text("TestHomePage"),
        if (!context.read<FirebaseAuthMethods>().user.emailVerified)
          TextButton(
              onPressed: () => setState(() {
                    log("${user.emailVerified}");
                  }),
              child: const Text("인증을 한 뒤에 눌러주세요.")),
        // Text("${user.displayName}"),
        Text("${user.email}"),
        Text("${user.emailVerified}"),
        Text("${user.metadata}"),
        // Text("${user.photoURL}"),
        TextButton(
            onPressed: () {
              context
                  .read<FirebaseAuthMethods>()
                  .sendEmailVerification(context);
            },
            child: const Text("다시 보내기")),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().deleteAccount(context);
            context.read<FirebaseAuthMethods>().signOut(context);
          },
          text: "sign Out",
        ),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
          text: "뒤로 가기",
        ),
        TextField(
          controller: _controller,
        ),
        CustomButton(
          onTap: () async {
            try {
              await context.read<FirebaseAuthMethods>().sendSignInLinkToEmail(
                    context: context,
                    email: _controller.text,
                    actionCodeSettings: acs,
                  );
            } catch (e) {
              log(e.toString());
            }
          },
          text: 'send Link sign up',
        ),
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
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailLinkSignUpScreen.routesName);
              },
              text: 'Email Link sign up',
            ),
          ],
        ),
      ),
    );
  }
}

class EmailLinkSignUpScreen extends StatefulWidget {
  const EmailLinkSignUpScreen({super.key});
  static String routesName = "emailLinkSignUp";

  @override
  State<EmailLinkSignUpScreen> createState() => _EmailLinkSignUpScreenState();
}

class _EmailLinkSignUpScreenState extends State<EmailLinkSignUpScreen>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'https://busan-matzip.firebaseapp.com/',
    // url: 'https://matzip.page.link/',
    // This must be true
    handleCodeInApp: true,
    iOSBundleId: 'com.example.busanUnivMatzip',
    androidPackageName: 'com.example.busan_univ_matzip',
    // installIfNotAvailable
    androidInstallApp: true,

    // minimumVersion
    androidMinimumVersion: '12',
    // dynamicLinkDomain: 'https://matzip.page.link/H3Ed',
  );
  void initDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.example.com/"),
      uriPrefix: "https://matzip.page.link/H3Ed",
      androidParameters:
          const AndroidParameters(packageName: "com.example.busan_univ_matzip"),
      iosParameters: const IOSParameters(bundleId: "com.example.ios"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          Text(EmailLinkSignUpScreen.routesName),
          CustomButton(
            onTap: () async {
              try {
                await context.read<FirebaseAuthMethods>().sendSignInLinkToEmail(
                      context: context,
                      email: _controller.text,
                      actionCodeSettings: acs,
                    );
              } catch (e) {
                log(e.toString());
              }
            },
            text: 'send Link sign up',
          ),
        ],
      )),
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
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    await context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: _email,
          password: _password,
          context: context,
        );
  }

  String? _emailValidator(String? value) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);

    // final pnuEmailValid =
    //     RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@pusan.ac.kr")
    //         .hasMatch(value);

    if (!emailValid) {
      return "이메일 양식을 맞춰주세요";
    }
    // if (!pnuEmailValid) {
    //   return "부산대 이메일 양식을 맞춰주세요";
    // }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.length < 6) {
      return "최소 6자 이상이여야합니다. ${value.length}/6";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(EmailSignUpScreen.routesName),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) {
                  _email = newValue!.trim();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _emailValidator,
                decoration: const InputDecoration(
                  hintText: "email",
                  fillColor: Color(0xffF5F6FA),
                ),
              ),
              TextFormField(
                controller: _passwordController,
                onSaved: (newValue) {
                  _password = newValue!.trim();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _passwordValidator,
                decoration: const InputDecoration(
                  hintText: "password",
                  fillColor: Color(0xffF5F6FA),
                ),
              ),
              TextButton(
                onPressed: () {
                  final credential = EmailAuthProvider.credential(
                      email: _email, password: _password);

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    signUpUser();
                  } else {
                    showSnackBar("양식을 확인해주세요", context);
                  }
                },
                child: const Text("signup"),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  } else {
                    showSnackBar("", context);
                  }
                },
                child: const Text("emailLink"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
