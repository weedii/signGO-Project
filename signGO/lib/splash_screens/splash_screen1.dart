import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../bottomnavbar.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo_last_edit.png"),
          const Text(
            "    Hands That Speak\nHeart That Understand",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Pacifico",
              fontSize: 23,
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 10, 35, 43),
      nextScreen: BottomNavBar(),
      splashIconSize: 409,
      duration: 1300,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
    );
  }
}
