import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/partyData.dart';
import 'package:dhanush/widgets/partyDataBottomSheet.dart';
import 'package:dhanush/widgets/partyExpansionTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';

class partyScreen extends StatefulWidget {
  FactoryData factoryData;
  partyScreen({super.key, required this.factoryData});

  @override
  State<partyScreen> createState() => _partyScreenState();
}

class _partyScreenState extends State<partyScreen> {
  Stream? partyData;

  getAllPartyData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getFactorySPT(widget.factoryData.id)
        .then((snapshots) {
      setState(() {
        partyData = snapshots;
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
    getAllPartyData();
  }

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
              StreamBuilder(
                stream: partyData,
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dataList = snapshot.data['party'];
                    if (snapshot.data['party'] != null) {
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
                            String partyId = getId(dataList[index]);
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("party")
                                    .doc(partyId)
                                    .snapshots(),
                                builder: ((context, AsyncSnapshot snapshot2) {
                                  if (snapshot2.hasData) {
                                    if (snapshot2.data != null) {
                                      var data2 = snapshot2.data;
                                      return partyExpansionTile(
                                          factoryId: widget.factoryData.id,
                                          partyData: PartyData(
                                              data2['partyId'],
                                              data2['partyLocation'],
                                              data2['partyName'],
                                              data2['paymentDone'],
                                              data2['paymentLeft']));
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

  void _addPartyData(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: partyDataBottomSheet(
            factoryId: widget.factoryData.id,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
