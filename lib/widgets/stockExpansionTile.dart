import 'package:dhanush/model/stockData.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:dhanush/widgets/stockDataUpdateBottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class stockExpansionTile extends StatelessWidget {
  String factoryId;
  StockData stockData;
  stockExpansionTile(
      {super.key, required this.stockData, required this.factoryId});

  @override
  Widget build(BuildContext context) {
    final data = stockData;
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(15),
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  _updateStockData(context, data);
                },
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete"),
                        content:
                            const Text("Are you sure you want to delete data?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 185, 70, 62)),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await DatabaseServices(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .deletingStockData(stockData, factoryId)
                                  .whenComplete(() {
                                showSnackbar(
                                    context, Colors.red, "Data deleted");
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )
      ],
    );
  }

  void _updateStockData(BuildContext context, StockData data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: stockDataUpdateBottomSheet(
            stockData: data,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
