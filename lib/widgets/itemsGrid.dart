import 'package:dhanush/screens/itemDescScreen.dart';
import 'package:flutter/material.dart';

class itemsGrid extends StatelessWidget {
  const itemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => itemDescScreen()));
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(children: [
          Image.asset(
            'assets/images/logoDhanush.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 280,
            filterQuality: FilterQuality.high,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              children: [Text("Brand Name"), Text("Item Name"), Text("Price")],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.favorite_border_outlined),
                onPressed: () {},
              )),
        ]),
      ),
    );
  }
}
