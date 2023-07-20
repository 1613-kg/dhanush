import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/screens/factoryDetailsScreen.dart';
import 'package:dhanush/screens/partyScreen.dart';
import 'package:dhanush/screens/stockScreen.dart';
import 'package:dhanush/screens/transportScreen.dart';
import 'package:flutter/material.dart';

class factoryExpansionTile extends StatefulWidget {
  FactoryData factoryData;
  factoryExpansionTile({super.key, required this.factoryData});

  @override
  State<factoryExpansionTile> createState() => _factoryExpansionTileState();
}

class _factoryExpansionTileState extends State<factoryExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final data = widget.factoryData;
    return InkWell(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => factoryDetailsScreen(
                      factoryData: widget.factoryData,
                    )));
      },
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(10),
        title: Text(data.name),
        subtitle: Text(data.location),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(""),
        ),
        children: [
          Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("Loaded Trucks: 0"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Trucks Left: 0"),
                    ],
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  TextButton(onPressed: () {}, child: Text("Update")),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    stockScreen(factoryData: data)));
                      },
                      child: Text("Stock")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    partyScreen(factoryData: data)));
                      },
                      child: Text("Party")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    transportScreen(factoryData: data)));
                      },
                      child: Text("Transport")),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
