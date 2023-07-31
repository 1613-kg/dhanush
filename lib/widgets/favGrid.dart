import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/itemDescScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class favGrid extends StatefulWidget {
  ItemsData itemsData;
  double price;
  bool isAdmin;
  favGrid(
      {super.key,
      required this.itemsData,
      required this.price,
      required this.isAdmin});

  @override
  State<favGrid> createState() => _favGridState();
}

class _favGridState extends State<favGrid> {
  bool isAddedTocart = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAddedTocart = (widget.itemsData.isAddedToCart
            .contains(FirebaseAuth.instance.currentUser!.uid))
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => itemDescScreen(
                      itemsData: widget.itemsData,
                      price: widget.price,
                      isAdmin: widget.isAdmin,
                    )));
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(children: [
          Image.network(
            widget.itemsData.imageUrl[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 280,
            filterQuality: FilterQuality.high,
          ),
          Positioned(
            bottom: 0,
            left: 5,
            child: Column(
              children: [
                Container(
                  // width: double.infinity,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: colorTheme),
                      onPressed: () async {
                        await DatabaseServices(
                                FirebaseAuth.instance.currentUser!.uid)
                            .toggleIsAddedToCart(widget.itemsData.id)
                            .then((value) {
                          setState(() {
                            isAddedTocart = !isAddedTocart;
                          });
                          (isAddedTocart)
                              ? showSnackbar(
                                  context, Colors.green, "Item added to cart")
                              : showSnackbar(context, Colors.red,
                                  "Item removed from cart");
                        });
                      },
                      child: Text(
                        (isAddedTocart) ? "Remove from cart" : "Add To Cart",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  //width: double.infinity,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: colorTheme),
                      onPressed: () async {
                        await DatabaseServices(
                                FirebaseAuth.instance.currentUser!.uid)
                            .toggleFav(widget.itemsData.id)
                            .whenComplete(
                          () {
                            showSnackbar(context, Colors.red, "Item removed");
                          },
                        );
                      },
                      child: Text(
                        "Remove",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
