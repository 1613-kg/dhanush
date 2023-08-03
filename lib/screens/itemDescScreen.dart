import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/buyNowScreen.dart';
import 'package:dhanush/screens/cartScreen.dart';
import 'package:dhanush/screens/favouritesScreen.dart';
import 'package:dhanush/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';
import '../services/databaseServices.dart';
import '../widgets/imageSlider.dart';

class itemDescScreen extends StatefulWidget {
  ItemsData itemsData;
  double price;
  bool isAdmin;
  itemDescScreen(
      {super.key,
      required this.itemsData,
      required this.price,
      required this.isAdmin});

  @override
  State<itemDescScreen> createState() => _itemDescScreenState();
}

class _itemDescScreenState extends State<itemDescScreen> {
  int quantity = 1;
  bool isFav = false;
  bool isAddedToCart = false;
  List<int> availableQuantities = [5, 10, 15, 20, 25, 30];

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
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    final data = widget.itemsData;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: colorTheme,
        title: Text(
          data.titleName[0].toUpperCase() + data.titleName.substring(1),
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                (widget.isAdmin)
                    ? showSnackbar(context, Colors.red, "Admin can't access")
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => favouritesScreen(
                                  price: widget.price,
                                  isAdmin: widget.isAdmin,
                                )));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                (widget.isAdmin)
                    ? showSnackbar(context, Colors.red, "Admin can't access")
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cartScreen(
                                  itemsData: widget.itemsData,
                                  quantity: quantity,
                                  price: widget.price,
                                )));
              },
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widht / 2,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: LinearBorder(), backgroundColor: colorTheme),
                onPressed: () async {
                  (widget.isAdmin)
                      ? showSnackbar(context, Colors.red, "Admin can't access")
                      : await DatabaseServices(
                              FirebaseAuth.instance.currentUser!.uid)
                          .toggleIsAddedToCart(widget.itemsData.id)
                          .then((value) {
                          setState(() {
                            isAddedToCart = !isAddedToCart;
                          });
                          (isAddedToCart)
                              ? showSnackbar(
                                  context, Colors.green, "Item added to cart")
                              : showSnackbar(context, Colors.red,
                                  "Item removed from cart");
                        });
                },
                child: Text(
                    (isAddedToCart) ? "Remove from cart" : "Add To Cart",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              width: widht / 2,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: LinearBorder(), backgroundColor: colorTheme),
                onPressed: () {
                  (widget.isAdmin)
                      ? showSnackbar(context, Colors.red, "Admin can't access")
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => buyNowScreen(
                                    itemsData: widget.itemsData,
                                    totalAmount: widget.price * quantity,
                                    quantity: quantity,
                                  )));
                },
                child: Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
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
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name :    ${widget.itemsData.titleName[0].toUpperCase() + widget.itemsData.titleName.substring(1)}",
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          "Brand :    ${widget.itemsData.brand[0].toUpperCase() + widget.itemsData.brand.substring(1)}",
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          "Price :    ₹${widget.price.toString()}",
                          style: textTheme.bodyLarge,
                        )
                      ],
                    ),
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
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "Select Quantity",
                          style: textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: availableQuantities.map((q) {
                            bool isSelected = q == quantity;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity = q;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: isSelected
                                    ? colorTheme
                                    : Colors.transparent,
                                child: Text(
                                  q.toString(),
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              quantityPopUp(context);
                            },
                            child: Text(
                              "Add Custom",
                              style: TextStyle(color: colorTheme),
                            )),
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
                height: height / 4,
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Product",
                          style: textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          data.description[0].toUpperCase() +
                              data.description.substring(1),
                          style: textTheme.bodyLarge,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: widht,
                height: height / 6,
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Rating",
                          style: textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: widget.itemsData.productRating,
                          itemCount: 5,
                          itemSize: 40,
                          itemBuilder: (context, _) {
                            return Icon(
                              Icons.star,
                              color: colorTheme,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  quantityPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter quantity"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    int? parsedValue =
                        int.tryParse(val); // Parse the String to int
                    if (parsedValue != null) {
                      setState(() {
                        quantity = parsedValue;
                      });
                    }
                  },
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20))),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ))
            ],
          );
        });
  }
}
