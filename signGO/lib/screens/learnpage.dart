import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final categoryHeight = size.height * 0.35;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 91, 116),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: size.height,
            child: Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: closeTopContainer ? 0 : 1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 300,
                              height: 280,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 26, 140, 179),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Here you can Learn   \n    sign language",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Pacifico",
                                        fontSize: 20,
                                      ),
                                    ),
                                    Image.asset("assets/images/hand.gif",
                                        width: 150)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.signlanguage101.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 40, 148, 162),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset("assets/images/site-0.png"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.startasl.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 193, 211),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset("assets/images/site-1.png"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.lessontutor.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 40, 148, 162),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset("assets/images/site-2.png"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.startasl.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 193, 211),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset(
                                        "assets/images/site-3.png",
                                        width: 200,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.signschool.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 40, 148, 162),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset("assets/images/site-4.png",
                                          width: 200),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.lingvano.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 193, 211),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Image.asset("assets/images/site-6.png",
                                          width: 200),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("www.mysigningtime.com");
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 400,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 40, 148, 162),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click Here!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Pacifico",
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 90),
                                      Image.asset("assets/images/site-7.png",
                                          width: 140),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
