import 'package:dhanush/constants.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/itemDescScreen.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class itemsGrid extends StatefulWidget {
  ItemsData itemsData;
  String priceString;
  bool isAdmin;
  itemsGrid(
      {super.key,
      required this.itemsData,
      required this.priceString,
      required this.isAdmin});

  @override
  State<itemsGrid> createState() => _itemsGridState();
}

class _itemsGridState extends State<itemsGrid> {
  bool isFav = false;
  double price = 0;

  double _parsePrice(String priceString) {
    // Remove any non-numeric characters and replace commas with dots
    String cleanedPrice =
        priceString.replaceAll(RegExp(r'[^\d.]'), '').replaceAll(',', '.');

    // Parse the string to a double
    //print(cleanedPrice + "😂😂😂");
    return double.parse(cleanedPrice);
  }

  getFav() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .isFav(widget.itemsData.id)
        .then((value) {
      setState(() {
        isFav = value!;
      });
    });
  }

  double getItemPrice(double price) {
    double priceOfCakeToSub = price / 2.2 * (61 / 100);
    double priceOf1kgOil = price + 500 - priceOfCakeToSub;
    double priceOf1LOil = priceOf1kgOil / 26;

    return (priceOf1LOil * widget.itemsData.quantity).roundToDouble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFav();
    price = getItemPrice(_parsePrice(widget.priceString));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => itemDescScreen(
                      itemsData: widget.itemsData,
                      price: price,
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
            bottom: 10,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Text(
                  "₹${price.toString()}",
                  style: textTheme.bodyLarge,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 0,
              child: IconButton(
                icon: (isFav)
                    ? Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      )
                    : Icon(Icons.favorite_border_outlined),
                onPressed: () async {
                  await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
                      .toggleFav(widget.itemsData.id)
                      .then((value) {
                    setState(() {
                      isFav = !isFav;
                    });
                    (isFav)
                        ? showSnackbar(
                            context, Colors.green, "Item added to favourites")
                        : showSnackbar(context, Colors.red,
                            "Item removed from favourites");
                  });
                },
              )),
        ]),
      ),
    );
  }
}
