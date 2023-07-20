import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/stockData.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/stockDataBottomSheet.dart';
import '../widgets/stockExpansionTile.dart';

class stockScreen extends StatefulWidget {
  FactoryData factoryData;
  stockScreen({super.key, required this.factoryData});

  @override
  State<stockScreen> createState() => _stockScreenState();
}

class _stockScreenState extends State<stockScreen> {
  Stream? stockDataId;

  getAllStockData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getFactorySPT(widget.factoryData.id)
        .then((snapshots) {
      setState(() {
        stockDataId = snapshots;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllStockData();
  }

  String getId(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stock"),
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
                      Text("Stock in ${widget.factoryData.name}"),
                      ElevatedButton(
                          onPressed: () {
                            _addStockData(context);
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
                stream: stockDataId,
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dataList = snapshot.data['stocks'];
                    if (snapshot.data['stocks'] != null) {
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
                            String stockId = getId(dataList[index]);

                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("stocks")
                                    .doc(stockId)
                                    .snapshots(),
                                builder: ((context, AsyncSnapshot snapshot2) {
                                  if (snapshot2.hasData) {
                                    if (snapshot2.data != null) {
                                      var data2 = snapshot2.data;
                                      return stockExpansionTile(
                                          factoryId: widget.factoryData.id,
                                          stockData: StockData(
                                              data2['stockId'],
                                              data2['amount'],
                                              data2['stockType'],
                                              data2['purchasedDate'].toDate(),
                                              data2['purchasedFrom'],
                                              data2['labCheck'],
                                              data2['addedById']));
                                    } else
                                      return Container();
                                  } else
                                    return loading();
                                }));
                            // int reverseIndex = dataList.length - index - 1;
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

  void _addStockData(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: stockDataBottomSheet(
            factoryId: widget.factoryData.id,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
