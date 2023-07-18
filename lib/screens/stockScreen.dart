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
  Stream? stockData;

  getAllStockData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getStockData()
        .then((snapshots) {
      setState(() {
        stockData = snapshots;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllStockData();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.factoryData;
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
                      Text("Stock in ${data.name}"),
                      ElevatedButton(
                          onPressed: () {
                            _addStoackData(context);
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
                stream: stockData,
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dataList = snapshot.data.docs;
                    // if (snapshot.data['stocks'] != null) {
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
                          int reverseIndex = dataList.length - index - 1;
                          final data = dataList[reverseIndex].data();
                          return stockExpansionTile(
                              stockData: StockData(
                                  data['stockId'],
                                  data['amount'],
                                  data['stockType'],
                                  data['purchasedDate'].toDate(),
                                  data['purchasedFrom'],
                                  data['labCheck'],
                                  data['addedById']));
                        },
                      );
                    } else
                      return Container();
                    // } else
                    //   return Container();
                  } else
                    return loading();
                }),
              ),
            ],
          ),
        ));
  }

  void _addStoackData(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: stockDataBottomSheet(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
