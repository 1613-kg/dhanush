import 'package:dhanush/constants.dart';
import 'package:dhanush/model/partyData.dart';
import 'package:dhanush/widgets/partyDataUpdateBottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';

class partyExpansionTile extends StatelessWidget {
  String factoryId;
  PartyData partyData;
  partyExpansionTile(
      {super.key, required this.partyData, required this.factoryId});

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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  _updatePartyData(context, data);
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
                                  .deletingPartyData(partyData, factoryId)
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

  void _updatePartyData(BuildContext context, PartyData data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: partyDataUpdateBottomSheet(
            partyData: data,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
