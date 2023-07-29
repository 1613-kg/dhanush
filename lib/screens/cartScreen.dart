import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/cartGrid.dart';
import '../widgets/loading.dart';

class cartScreen extends StatefulWidget {
  ItemsData itemsData;
  int quantity;
  double price;
  cartScreen(
      {super.key,
      required this.itemsData,
      required this.quantity,
      required this.price});

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  Stream? user;

  getUserData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getUserData()
        .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: user,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var dataList = snapshot.data['isAddedToCart'];
            if (snapshot.data['isAddedToCart'] != null) {
              if (dataList.length != 0) {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    String itemId = dataList[index];
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("items")
                          .doc(itemId)
                          .snapshots(),
                      builder: ((context, AsyncSnapshot snapshot2) {
                        if (snapshot2.hasData) {
                          if (snapshot2.data != null) {
                            var data2 = snapshot2.data;
                            return cartGrid(
                              itemsData: ItemsData(
                                  data2['brand'],
                                  data2['description'],
                                  data2['itemsId'],
                                  data2['quantity'],
                                  data2['titleName'],
                                  data2['unit'],
                                  data2['imageUrl'].cast<String>(),
                                  data2['isFav'].cast<String>(),
                                  data2['isAddedToCart'].cast<String>(),
                                  data2['webUrl'],
                                  data2['productRating']),
                              quantity: widget.quantity,
                              price: widget.price,
                            );
                          } else
                            return Container();
                        } else
                          return Container();
                      }),
                    );
                  },
                );
              } else
                return Container();
            } else
              return Container();
          } else
            return loading();
        }),
      ),
    );
  }
}
