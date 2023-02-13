import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/screen/home_page_screen.dart';
import 'package:busan_univ_matzip/screen/sign_up_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
          // '/': (context) => const PostScreen(),
          '/': (context) => const MyHomePage(),
          '/signUp': (context) => const SignUpScreen(),
          '/homePage': (context) => const MyHomePage(),
        },
        theme: FlexThemeData.light(
          scheme: FlexScheme.red,
          appBarBackground: Colors.black,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 9,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            inputDecoratorUnfocusedHasBorder: false,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,

          // To use the playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.red,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 15,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            inputDecoratorUnfocusedHasBorder: false,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
      ),
    );
  }
}
