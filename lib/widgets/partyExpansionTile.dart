import 'package:dhanush/model/partyData.dart';
import 'package:flutter/material.dart';

class partyExpansionTile extends StatelessWidget {
  PartyData partyData;
  partyExpansionTile({super.key, required this.partyData});

  @override
  Widget build(BuildContext context) {
    final data = partyData;
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(10),
      title: Text(data.partyName),
      subtitle: Text(data.partyLocation),
      leading: Icon(Icons.group),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Payment Left: "),
            Text(data.paymentLeft.toString()),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Payment Done: "),
            Text(data.paymentDone.toString()),
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
