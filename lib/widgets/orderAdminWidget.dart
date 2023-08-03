import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/itemsData.dart';
import '../model/orderData.dart';
import '../model/userData.dart';
import '../services/databaseServices.dart';

class orderAdminWidget extends StatefulWidget {
  OrderData orderData;
  orderAdminWidget({super.key, required this.orderData});

  @override
  State<orderAdminWidget> createState() => _orderAdminWidgetState();
}

class _orderAdminWidgetState extends State<orderAdminWidget> {
  ItemsData itemsData = ItemsData("brand", "description", "id", 0, "titleName",
      "unit", ["imageUrl"], [""], [], "", 0, DateTime.now());
  UserData userData = UserData('id', 'email', 'userName', false, 'password',
      'profilePic', ['isFav'], ['isAddedToCart']);

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

  getUser() async {
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingUserIdData(widget.orderData.buyerId);

    setState(() {
      userData.id = snapshot.docs[0]['uid'];
      userData.email = snapshot.docs[0]['email'];
      userData.userName = snapshot.docs[0]['userName'];
      userData.isAdmin = snapshot.docs[0]['isAdmin'];
      userData.isAddedToCart = snapshot.docs[0]['isAddedToCart'].cast<String>();
      userData.isFav = snapshot.docs[0]['isFav'].cast<String>();
      userData.profilePic = snapshot.docs[0]['profilePic'];
      userData.password = snapshot.docs[0]['password'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemsData(widget.orderData.itemId);
    getUser();
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
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            //placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(
              Icons.image,
              size: 150,
            ),
            //radius: 150,
            imageUrl: itemsData.imageUrl[0],
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
              "Buyer: ${userData.userName}",
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
