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
      //
      // Zaa Body is here
      body: Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 91, 116),
        appBar: AppBar(
          elevation: 15,
          backgroundColor: Color.fromARGB(255, 26, 140, 179),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(0)),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Welcome to\nsignGO",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Pacifico",
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
