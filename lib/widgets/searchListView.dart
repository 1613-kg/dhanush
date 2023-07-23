import 'package:dhanush/model/itemsData.dart';
import 'package:flutter/material.dart';

class searchListView extends StatelessWidget {
  ItemsData itemsData;
  searchListView({super.key, required this.itemsData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: LinearBorder(side: BorderSide(color: Colors.white, width: 5)),
      contentPadding: EdgeInsets.all(25),
      leading: Image.network(itemsData.imageUrl[0]),
      title: Text(itemsData.titleName),
      subtitle: Text(itemsData.brand),
    );
  }
}
