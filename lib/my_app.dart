import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/route_handling/auth_page.dart';
import 'package:busan_univ_matzip/route_handling/home_page.dart';
import 'package:busan_univ_matzip/screen/add_post_screen.dart';
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
          '/': (context) => const AuthPage(),
          '/signUp': (context) => const SignUpScreen(),
          '/homePage': (context) => const HomePage(),
          '/homePage/addPost': (context) => const AddPostScreen(),
        },

        // This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
        theme: FlexThemeData.light(
          scheme: FlexScheme.red,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 9,
          appBarBackground: Colors.black,
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
          appBarBackground: Colors.black,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            inputDecoratorUnfocusedHasBorder: false,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
      ),
    );
  }
}
