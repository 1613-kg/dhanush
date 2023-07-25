import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dhanush/screens/userOrders.dart';
import 'package:flutter/material.dart';

class successScreen extends StatelessWidget {
  successScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: AnimatedSplashScreen(
      duration: 1200,
      backgroundColor: Colors.green,
      splashIconSize: h,
      splash: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 100,
              child: Icon(
                Icons.visibility,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Success".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ],
        )),
      ),
      nextScreen: userOrder(),
    ));
  }
}
