import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/screens/addFactoryData.dart';
import 'package:dhanush/screens/addItemScreen.dart';
import 'package:dhanush/widgets/factoryExpansionTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';
import 'factoryDetailsScreen.dart';

class adminServices extends StatefulWidget {
  String userName;
  adminServices({super.key, required this.userName});

  @override
  State<adminServices> createState() => _adminServicesState();
}

class _adminServicesState extends State<adminServices> {
  Stream? factoryData;

  getAllFactoryData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getFactoryData()
        .then((snapshots) {
      setState(() {
        factoryData = snapshots;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFactoryData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        backgroundColor: colorTheme,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: CircleAvatar(
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addFactoryData()));
              },
              icon: Icon(
                Icons.add,
              )),
          radius: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.account_circle,
                size: 250,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.userName),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Password",
                      style: textTheme.bodySmall,
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Change",
                          style: TextStyle(color: Colors.purpleAccent),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: factoryData,
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
                          final data = dataList[index].data();
                          return factoryExpansionTile(
                            factoryData: FactoryData(
                              data['factoryId'],
                              data['location'],
                              data['description'],
                              data['image'].cast<String>(),
                              data['name'],
                              data['party'].cast<String>(),
                              data['stocks'].cast<String>(),
                              data['transport'].cast<String>(),
                            ),
                          );
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
        ),
      ),
    );
  }
}
