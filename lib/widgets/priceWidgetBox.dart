import 'package:flutter/material.dart';

class priceWidgetBox extends StatefulWidget {
  String text;
  String price;
  IconData iconData;
  priceWidgetBox(
      {super.key,
      required this.price,
      required this.text,
      required this.iconData});

  @override
  State<priceWidgetBox> createState() => _priceWidgetBoxState();
}

class _priceWidgetBoxState extends State<priceWidgetBox> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return ListTile(
      leading: Icon(widget.iconData),
      title: Text(widget.text),
      subtitle: Text(widget.price),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {},
      ),
    );
  }
}
