import 'package:flutter/material.dart';
import 'package:signgo/bottomnavbar.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // To handle the red error page between home and camera
    return const BottomNavBar();
  };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const signGO());
}

class signGO extends StatelessWidget {
  const signGO({super.key});

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
