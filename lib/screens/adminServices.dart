import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/model/userData.dart';
import 'package:dhanush/screens/addFactoryData.dart';
import 'package:dhanush/screens/addItemScreen.dart';
import 'package:dhanush/widgets/factoryExpansionTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';
import 'factoryDetailsScreen.dart';

class adminServices extends StatefulWidget {
  UserData userData;
  adminServices({super.key, required this.userData});

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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Admin Services",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorTheme,
        onPressed: () {},
        child: CircleAvatar(
          child: IconButton(
            onPressed: () {
              showDialogOpt(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          backgroundColor: colorTheme,
          radius: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CachedNetworkImage(
                  height: height / 4,
                  width: widht / 1.5,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                        backgroundColor: colorTheme,
                        radius: 100,
                      ),
                  //radius: 150,
                  imageUrl: widget.userData.profilePic),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.userData.userName.toUpperCase(),
                style: textTheme.titleLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
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
                              data['timeStamp'].toDate(),
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

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addItemScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add_card_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Add Item"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addFactoryData()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add_business_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Add Factory Date"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Close"),
                    ],
                  ),
                )
              ],
            ));
  }
}
