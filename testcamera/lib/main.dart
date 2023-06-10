import 'package:flutter/material.dart';
import 'package:signgo/bottomnavbar.dart';
import 'package:signgo/homepage.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // To handle the red error page between home and camera
    return const HomePage();
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
      home: const BottomNavBar(),
      theme: ThemeData(),
    );
  }
}
