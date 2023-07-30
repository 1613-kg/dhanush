import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/feedbaks.dart';
import 'package:flutter/material.dart';

class successScreen extends StatelessWidget {
  ItemsData itemsData;
  successScreen({super.key, required this.itemsData});

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
              backgroundColor: Colors.white,
              radius: 80,
              child: Icon(
                Icons.done,
                size: 100,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Order Placed".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
      nextScreen: feedbacks(
        itemsData: itemsData,
      ),
    ));
  }
}
