import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/loginScreen.dart';
import 'package:dhanush/screens/searchScreen.dart';
import 'package:dhanush/services/authServices.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:dhanush/widgets/itemsGrid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/loginData.dart';
import '../widgets/customDrawer.dart';
import '../widgets/homeImageSlider.dart';
import '../widgets/loading.dart';
import '../widgets/priceWidgetBox.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String email = "";
  String userName = "";
  Stream? itemsData;

  getItemsData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getItemsData()
        .then((value) {
      setState(() {
        itemsData = value;
      });
    });
  }

  getUserData() async {
    await LoginData.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await LoginData.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getItemsData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dhanush"),
        backgroundColor: colorTheme,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => searchScreen())));
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: customDrawer(
        userName: userName,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeImageSlider(),
              SizedBox(height: 25),
              Text(
                "Live Price",
                style: textTheme.titleLarge,
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.pin_drop_sharp,
                price: "180/kg",
                text: "Mustard",
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.oil_barrel,
                price: "120/L",
                text: "Oil",
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.cake,
                price: "500/kg",
                text: "Mustard Cake",
              ),
              SizedBox(height: 25),
              Text(
                "Items available",
                style: textTheme.titleLarge,
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: itemsData,
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dataList = snapshot.data.docs;
                    // if (snapshot.data['stocks'] != null) {
                    if (dataList.length != 0) {
                      return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: widht / height),
                          itemBuilder: (context, index) {
                            final data = dataList[index].data();
                            return itemsGrid(
                              itemsData: ItemsData(
                                  data['brand'],
                                  data['description'],
                                  data['itemsId'],
                                  data['quantity'],
                                  data['titleName'],
                                  data['unit'],
                                  data['imageUrl'].cast<String>(),
                                  data['isFav'].cast<String>(),
                                  data['isAddedToCart'].cast<String>(),
                                  data['webUrl'],
                                  data['productRating']),
                            );
                          });
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
