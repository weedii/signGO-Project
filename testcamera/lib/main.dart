import 'package:flutter/material.dart';
import 'package:signgo/bottomnavbar.dart';
import 'splash_screens/splash_screen1.dart';


Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // To handle the red screen error page between home an camera
    return const BottomNavBar();
  };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SignGO());
}

class SignGO extends StatelessWidget {
  const SignGO({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'signGO app',
      home: const SplashScreen1(),
      theme: ThemeData(),
    );
  }
}
