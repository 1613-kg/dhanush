import 'package:dhanush/model/transport.dart';
import 'package:dhanush/widgets/transportDataUpdateBottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class transportExpanionTile extends StatelessWidget {
  String factoryId;
  TransportData transportData;
  transportExpanionTile(
      {super.key, required this.transportData, required this.factoryId});

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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  _updateTransportData(context, data);
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
                                  .deletingTransportData(
                                      transportData, factoryId)
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

  void _updateTransportData(BuildContext context, TransportData data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: transportDataUpdateBottomSheet(
            transportData: data,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
