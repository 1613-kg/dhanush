import 'package:dhanush/constants.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/itemDescScreen.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class itemsGrid extends StatefulWidget {
  ItemsData itemsData;
  double price;
  itemsGrid({super.key, required this.itemsData, required this.price});

  @override
  State<itemsGrid> createState() => _itemsGridState();
}

class _itemsGridState extends State<itemsGrid> {
  bool isFav = false;

  getFav() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .isFav(widget.itemsData.id)
        .then((value) {
      setState(() {
        isFav = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFav();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => itemDescScreen(
                      itemsData: widget.itemsData,
                      price: widget.price,
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
              children: [
                Text(widget.itemsData.brand),
                Text(widget.itemsData.titleName),
                Text("180")
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
