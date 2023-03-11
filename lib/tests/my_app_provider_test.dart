import 'package:busan_univ_matzip/providers/services/firebase_auth_methods.dart';
import 'package:busan_univ_matzip/providers/user_firebase_provider.dart';
import 'package:busan_univ_matzip/tests/auth_check_page.dart';
import 'package:busan_univ_matzip/tests/email_sign_in_screen.dart';
import 'package:busan_univ_matzip/tests/google_sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserFBProvider(),
        ),
        Provider<FirebaseAuthMethods>(
          create: (context) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        // StreamProvider(
        //   create: (context) => context.read<FirebaseAuthMethods>().snapShot,
        //   initialData: null,
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthCheckPage(),
        routes: {
          EmailSignInScreen.routesName: (context) => const EmailSignInScreen(),
          EmailSignUpScreen.routesName: (context) => const EmailSignUpScreen(),
          EmailLinkSignUpScreen.routesName: (context) =>
              const EmailLinkSignUpScreen(),
          GoogleSignInScreen.routesName: (context) =>
              const GoogleSignInScreen(),
        },
      ),
    );
  }
}
