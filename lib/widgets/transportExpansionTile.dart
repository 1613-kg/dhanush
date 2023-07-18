import 'package:dhanush/model/transport.dart';
import 'package:flutter/material.dart';

class transportExpanionTile extends StatelessWidget {
  TransportData transportData;
  transportExpanionTile({super.key, required this.transportData});

  @override
  Widget build(BuildContext context) {
    final data = transportData;
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(10),
      title: Text(data.deliveredTo),
      subtitle: Text(data.truckNumber),
      leading: Icon(Icons.fire_truck),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Driver Name: "),
            Text(data.driverName),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Driver Number: "),
            Text(data.driverContact),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Owner: "),
            Text(data.owner),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Departed From: "),
            Text(data.deliveredFrom),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Departure Time: "),
            Text(data.leavingTime.toString()),
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
