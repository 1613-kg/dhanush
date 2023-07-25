import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/buyNowScreen.dart';
import 'package:dhanush/screens/cartScreen.dart';
import 'package:dhanush/screens/favouritesScreen.dart';
import 'package:dhanush/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';
import '../widgets/imageSlider.dart';

class itemDescScreen extends StatefulWidget {
  ItemsData itemsData;
  double price;
  itemDescScreen({super.key, required this.itemsData, required this.price});

  @override
  State<itemDescScreen> createState() => _itemDescScreenState();
}

class _itemDescScreenState extends State<itemDescScreen> {
  int quantity = 1;
  bool isFav = false;
  bool isAddedToCart = false;

  getFavAndCart() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .isFav(widget.itemsData.id)
        .then((value) {
      setState(() {
        isFav = value!;
      });
    });

    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .isAddedToCart(widget.itemsData.id)
        .then((value) {
      setState(() {
        isAddedToCart = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavAndCart();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    final data = widget.itemsData;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.redAccent,
        title: Text(data.titleName),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => favouritesScreen(
                              price: widget.price,
                            )));
              },
              icon: Icon(
                Icons.favorite,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cartScreen(
                              itemsData: widget.itemsData,
                              quantity: quantity,
                              price: widget.price,
                            )));
              },
              icon: Icon(Icons.shopping_bag)),
        ],
      ),
      body: SingleChildScrollView(
        child: (Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageSlider(
                  images: data.imageUrl,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 8,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(data.brand),
                        Text("250"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: widht,
                  height: height / 5,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Select Quantity"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((2 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((3 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((4 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((5 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((6 * 5).toString())),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {}, child: Text("Add Custom")),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 5,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: widht,
                          child: ElevatedButton(
                              onPressed: () async {
                                await DatabaseServices(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    .toggleIsAddedToCart(widget.itemsData.id)
                                    .then((value) {
                                  setState(() {
                                    isAddedToCart = !isAddedToCart;
                                  });
                                  (isAddedToCart)
                                      ? showSnackbar(context, Colors.green,
                                          "Item added to cart")
                                      : showSnackbar(context, Colors.red,
                                          "Item removed from cart");
                                });
                              },
                              child: Text((isAddedToCart)
                                  ? "Remove from cart"
                                  : "Add To Cart")),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: widht,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => buyNowScreen(
                                              itemsData: widget.itemsData,
                                              totalAmount:
                                                  widget.price * quantity,
                                              quantity: quantity,
                                            )));
                              },
                              child: Text("Buy Now")),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 4,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("About Product"),
                        Text(data.description),
                      ],
                    ),
                  ),
                ),
              ],
              // ),
            ))),
      ),
    );
  }
}
