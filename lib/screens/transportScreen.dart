import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/transport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';
import '../widgets/transportDataBottomSheet.dart';
import '../widgets/transportExpansionTile.dart';

class transportScreen extends StatefulWidget {
  FactoryData factoryData;
  transportScreen({super.key, required this.factoryData});

  @override
  State<transportScreen> createState() => _transportScreenState();
}

class _transportScreenState extends State<transportScreen> {
  Stream? transportData;

  getAllTransportData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getFactorySPT(widget.factoryData.id)
        .then((snapshots) {
      setState(() {
        transportData = snapshots;
      });
    });
  }

  String getId(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTransportData();
  }

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
              StreamBuilder(
                stream: transportData,
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dataList = snapshot.data['transport'];
                    if (snapshot.data['transport'] != null) {
                      if (dataList.length != 0) {
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            String transportId = getId(dataList[index]);
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("transport")
                                    .doc(transportId)
                                    .snapshots(),
                                builder: ((context, AsyncSnapshot snapshot2) {
                                  if (snapshot2.hasData) {
                                    if (snapshot2.data != null) {
                                      var data = snapshot2.data;
                                      return transportExpanionTile(
                                          factoryId: widget.factoryData.id,
                                          transportData: TransportData(
                                              data['transportId'],
                                              data['truckNumber'],
                                              data['driverContact'],
                                              data['driverName'],
                                              data['owner'],
                                              data['deliveredFrom'],
                                              data['deliveredTo'],
                                              data['leavingTime'].toDate()));
                                    } else
                                      return Container();
                                  } else
                                    return loading();
                                }));
                          },
                        );
                      } else
                        return Container();
                    } else
                      return Container();
                  } else
                    return loading();
                }),
              ),
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
          child: transportDataBottomSheet(
            factoryId: widget.factoryData.id,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
