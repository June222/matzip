import 'package:busan_univ_matzip/firebase_options.dart';
import 'package:busan_univ_matzip/tests/my_app_provider_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // 회전 금지

  runApp(const MyAppProvider());
}
