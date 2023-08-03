import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/itemDescScreen.dart';
import 'package:flutter/material.dart';

class searchListView extends StatefulWidget {
  ItemsData itemsData;
  String priceString;
  bool isAdmin;
  searchListView(
      {super.key,
      required this.itemsData,
      required this.isAdmin,
      required this.priceString});

  @override
  State<searchListView> createState() => _searchListViewState();
}

class _searchListViewState extends State<searchListView> {
  double price = 0;
  double _parsePrice(String priceString) {
    // Remove any non-numeric characters and replace commas with dots
    String cleanedPrice =
        priceString.replaceAll(RegExp(r'[^\d.]'), '').replaceAll(',', '.');

    // Parse the string to a double
    //print(cleanedPrice + "😂😂😂");
    return double.parse(cleanedPrice);
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

    price = getItemPrice(_parsePrice(widget.priceString));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => itemDescScreen(
                    itemsData: widget.itemsData,
                    price: price,
                    isAdmin: widget.isAdmin)));
      },
      shape: LinearBorder(side: BorderSide(color: Colors.white, width: 5)),
      contentPadding: EdgeInsets.all(25),
      leading: CachedNetworkImage(
        fit: BoxFit.cover,
        // placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(
          Icons.image,
          size: 20,
        ),
        //radius: 150,
        imageUrl: widget.itemsData.imageUrl[0],
      ),
      title: Text(widget.itemsData.titleName),
      subtitle: Text(widget.itemsData.brand),
    );
  }
}
