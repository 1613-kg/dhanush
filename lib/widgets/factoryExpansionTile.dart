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
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
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
        title: Text(data.name[0].toUpperCase() + data.name.substring(1)),
        subtitle:
            Text(data.location[0].toUpperCase() + data.location.substring(1)),
        leading: CircleAvatar(
          backgroundColor: colorTheme,
          child: Text(
            data.name[0].toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        children: [
          Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.withOpacity(0.8)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    stockScreen(factoryData: data)));
                      },
                      child: Text(
                        "Stock",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.withOpacity(0.8)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    partyScreen(factoryData: data)));
                      },
                      child: Text(
                        "Party",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTheme.withOpacity(0.8)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    transportScreen(factoryData: data)));
                      },
                      child: Text(
                        "Transport",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
