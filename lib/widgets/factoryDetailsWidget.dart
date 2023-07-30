import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class factoryDetailsWidget extends StatelessWidget {
  String title;
  String content;
  factoryDetailsWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title: ",
          style: TextStyle(fontSize: 15),
        ),
        Container(
          width: 230,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white30, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AutoSizeText(
            content[0].toUpperCase() + content.substring(1),
            //textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
