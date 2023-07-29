import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/itemsData.dart';
import '../model/orderData.dart';
import '../services/databaseServices.dart';

class orderAdminWidget extends StatefulWidget {
  OrderData orderData;
  String userName;
  orderAdminWidget(
      {super.key, required this.orderData, required this.userName});

  @override
  State<orderAdminWidget> createState() => _orderAdminWidgetState();
}

class _orderAdminWidgetState extends State<orderAdminWidget> {
  ItemsData itemsData = ItemsData("brand", "description", "id", 0, "titleName",
      "unit", ["imageUrl"], [""], [], "", 0);

  getItemsData(String itemId) async {
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingItemsData(itemId);

    setState(() {
      itemsData.brand = snapshot.docs[0]['brand'];
      itemsData.titleName = snapshot.docs[0]['titleName'];
      itemsData.imageUrl = snapshot.docs[0]['imageUrl'].cast<String>();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemsData(widget.orderData.itemId);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Container(
      width: double.infinity,
      height: 370,
      child: Card(
        child: Stack(children: [
          Image.network(
            itemsData.imageUrl[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Positioned(
            bottom: 120,
            left: 10,
            child: Text(
              "Name: ${itemsData.titleName}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 10,
            child: Text(
              "Brand: ${itemsData.brand}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 10,
            child: Text(
              "Price: ${widget.orderData.price} (${widget.orderData.paymentType == "Cash on delivery" ? "Cod" : "Paid Online"})",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 10,
            child: Text(
              "Quantity: ${widget.orderData.quantity}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 10,
            child: Text(
              "Buyer: ${widget.userName}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 10,
            child: Text(
              "Date: ${DateFormat.yMd().format(widget.orderData.date)}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            bottom: 10,
            //right: 10,
            child: Container(
              width: 350,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 10),
              child: AutoSizeText(
                "Address: ${widget.orderData.address}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
