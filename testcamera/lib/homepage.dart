import 'package:flutter/material.dart';
import 'package:signgo/screens/camerapage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 1.1, end: 1.25).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      // Zaa Body is here
      body: Container(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 18, 91, 116),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: GestureDetector(
                      onTap: () {
                        // Handle button tap here
                        // For example, you can navigate to another page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoRecordingPage()),
                        );
                      },
                      child: Image.asset(
                        "assets/images/logo_last_edit.png",
                      ),
                    ),
                  );
                },
              ),
              const Text(
                "Go Live",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Pacifico",
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
