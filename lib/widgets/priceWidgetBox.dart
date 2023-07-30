import 'package:dhanush/screens/aboutPrice.dart';
import 'package:flutter/material.dart';

class priceWidgetBox extends StatelessWidget {
  String text;
  String price;
  IconData iconData;
  priceWidgetBox(
      {super.key,
      required this.price,
      required this.text,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: colorTheme,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => aboutPrice()));
        },
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
        leading: Icon(
          iconData,
          color: Colors.white,
        ),
        subtitle: Text(
          price,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
