import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/transport.dart';
import 'package:flutter/material.dart';

import '../widgets/transportDataBottomSheet.dart';
import '../widgets/transportExpansionTile.dart';

class transportScreen extends StatefulWidget {
  FactoryData factoryData;
  transportScreen({super.key, required this.factoryData});

  @override
  State<transportScreen> createState() => _transportScreenState();
}

class _transportScreenState extends State<transportScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.factoryData;
    return Scaffold(
        appBar: AppBar(
          title: Text("Transport"),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Transport in ${data.name}"),
                      ElevatedButton(
                          onPressed: () {
                            _addTransportData(context);
                          },
                          child: Text("Add"))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return transportExpanionTile(
                        transportData: TransportData(
                      "",
                      "4967",
                      "6846166105",
                      "Raju",
                      "Ambey",
                      "Bheem",
                      "partyName",
                      DateTime.now(),
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 10),
            ],
          ),
        ));
  }

  void _addTransportData(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: transportDataBottomSheet(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
