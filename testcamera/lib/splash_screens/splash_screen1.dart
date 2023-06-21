import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../bottomnavbar.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/images/logo.png"),
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
      nextScreen: Scaffold(
        body: SlideTransition(
          position: _slideAnimation,
          child: BottomNavBar(),
        ),
      ),
      splashIconSize: 500,
      duration: 1900,
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
