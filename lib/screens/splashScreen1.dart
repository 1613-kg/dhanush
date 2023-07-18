import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dhanush/screens/homeScreen.dart';
import 'package:dhanush/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../services/loginData.dart';

class splashScreen1 extends StatefulWidget {
  const splashScreen1({super.key});

  @override
  State<splashScreen1> createState() => _splashScreen1State();
}

class _splashScreen1State extends State<splashScreen1> {
  bool isSigned = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await LoginData.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          isSigned = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedSplashScreen(
            duration: 1200,
            backgroundColor: Theme.of(context).primaryColor,
            splashIconSize: h,
            splash: Container(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Dhanush Oil",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          endIndent: 10,
                          indent: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "100% healthy",
                        style: TextStyle(color: Colors.white54, fontSize: 20),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            nextScreen: (isSigned) ? homeScreen() : loginScreen()));
  }
}
