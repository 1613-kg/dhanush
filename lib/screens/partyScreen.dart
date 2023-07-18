import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/partyData.dart';
import 'package:dhanush/widgets/partyDataBottomSheet.dart';
import 'package:dhanush/widgets/partyExpansionTile.dart';
import 'package:flutter/material.dart';

class partyScreen extends StatefulWidget {
  FactoryData factoryData;
  partyScreen({super.key, required this.factoryData});

  @override
  State<partyScreen> createState() => _partyScreenState();
}

class _partyScreenState extends State<partyScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.factoryData;
    return Scaffold(
        appBar: AppBar(
          title: Text("Party"),
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
                      Text("Party in ${data.name}"),
                      ElevatedButton(
                          onPressed: () {
                            _addPartyData(context);
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
                    return partyExpansionTile(
                        partyData: PartyData("", "", "", 1.0, 1.0));
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

  void _addPartyData(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: partyDataBottomSheet(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
