import 'package:dhanush/model/stockData.dart';
import 'package:flutter/material.dart';

class stockExpansionTile extends StatelessWidget {
  StockData stockData;
  stockExpansionTile({super.key, required this.stockData});

  @override
  Widget build(BuildContext context) {
    final data = stockData;
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(10),
      title: Text(data.type),
      subtitle: Text(data.stock),
      leading: Icon(Icons.storage),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Stock Available: "),
            Text(data.stock),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Purchased from: "),
            Text(data.buyingParty),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Purchased Date: "),
            Text(data.buyingDate.toString()),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Added By: "),
            Text(data.addedById),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Lab Checking: "),
            (data.labCheck == true) ? Text("Cheked") : Text("Not Checked"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Update")),
            ElevatedButton(onPressed: () {}, child: Text("Delete"))
          ],
        )
      ],
    );
  }
}
