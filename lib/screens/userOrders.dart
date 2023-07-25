import 'package:flutter/material.dart';

class userOrder extends StatefulWidget {
  const userOrder({super.key});

  @override
  State<userOrder> createState() => _userOrderState();
}

class _userOrderState extends State<userOrder> {
  Stream? orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Your Orders"),
      ),
    );
  }
}
