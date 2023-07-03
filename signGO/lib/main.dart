import 'package:flutter/material.dart';
import 'package:signgo/bottomnavbar.dart';
import 'splash_screens/splash_screen1.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // To handle the red screen error page between home and camera
    // of the _controller not initialized by showing the BottomNavBar widget
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
      title: 'signGO',
      home: const SplashScreen1(),
    );
  }
}
