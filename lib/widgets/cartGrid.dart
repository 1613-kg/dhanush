import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/buyNowScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';

class cartGrid extends StatefulWidget {
  ItemsData itemsData;
  int quantity;
  double price;
  cartGrid(
      {super.key,
      required this.itemsData,
      required this.quantity,
      required this.price});

  @override
  State<cartGrid> createState() => _cartGrid();
}

class _cartGrid extends State<cartGrid> {
  bool isAddedTocart = false;
  double updatePrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAddedTocart = (widget.itemsData.isAddedToCart
            .contains(FirebaseAuth.instance.currentUser!.uid))
        ? true
        : false;
    updatePrice = widget.price * widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: colorTheme.withOpacity(0.4), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Image.network(widget.itemsData.imageUrl[0]),
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.3),
                radius: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemsData.titleName[0].toUpperCase() +
                        widget.itemsData.titleName.substring(1),
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    widget.itemsData.brand[0].toUpperCase() +
                        widget.itemsData.brand.substring(1),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                width: 80,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      (widget.quantity == 1)
                          ? InkWell(
                              onTap: () async {
                                await DatabaseServices(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    .toggleIsAddedToCart(widget.itemsData.id);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Colors.white30, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.delete),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  widget.quantity = widget.quantity - 1;
                                  updatePrice = widget.price * widget.quantity;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.white30, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.remove)),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.white30, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AutoSizeText(
                          widget.quantity.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.quantity = widget.quantity + 1;
                            updatePrice = widget.price * widget.quantity;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: Colors.white30, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AutoSizeText(
                        updatePrice.toString(),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: colorTheme),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => buyNowScreen(
                                itemsData: widget.itemsData,
                                totalAmount: updatePrice,
                                quantity: widget.quantity,
                              )));
                },
                child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
