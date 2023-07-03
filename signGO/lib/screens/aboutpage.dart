import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 91, 116),
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Color.fromARGB(255, 26, 140, 179),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(300)),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(530),
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Pacifico",
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "signGO",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: "Pacifico",
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.0,
                  width: 350,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 1.0,
                  width: 300,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 1.0,
                  width: 200,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  "assets/images/b.png",
                  width: 410,
                  height: 456,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Text(
            "Now with signGO you can\n connect with anyone with\n           simple clicks",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Pacifico",
              fontSize: 29,
            ),
          ),
        ),
      ),
    );
  }
}
