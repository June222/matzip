import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/screen/home_page_screen.dart';
import 'package:busan_univ_matzip/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ColorManager colorManager = ColorManager();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/signUp': (context) => const SignUpScreen(),
          '/homePage': (context) => const MyHomePage(),
        },
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              backgroundColor: Colors.black,
              elevation: 1.5,
            ),
            primarySwatch: Colors.deepOrange),

        // home: const LoginScreen(),
      ),
    );
  }
}
