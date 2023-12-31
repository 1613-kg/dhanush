import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/model/userData.dart';

import 'package:dhanush/screens/searchScreen.dart';

import 'package:dhanush/services/databaseServices.dart';
import 'package:dhanush/services/getPrices.dart';
import 'package:dhanush/widgets/itemsGrid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;
  bool _dataFetched = false;

  List<Map<String, dynamic>> _prices = [];
  UserData userData = UserData('id', 'email', 'userName', false, 'password',
      'profilePic', ['isFav'], ['isAddedToCart']);
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
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingUserIdData(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userData.id = snapshot.docs[0]['uid'];
      userData.email = snapshot.docs[0]['email'];
      userData.userName = snapshot.docs[0]['userName'];
      userData.isAdmin = snapshot.docs[0]['isAdmin'];
      userData.isAddedToCart = snapshot.docs[0]['isAddedToCart'].cast<String>();
      userData.isFav = snapshot.docs[0]['isFav'].cast<String>();
      userData.profilePic = snapshot.docs[0]['profilePic'];
      userData.password = snapshot.docs[0]['password'];
    });
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Prices().fetchMustardPrices().then((value) {
        setState(() {
          _prices = value;
          isLoading = false;
          _dataFetched = true;
        });
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getItemsData();
    if (!_dataFetched) _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dhanush",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorTheme,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => searchScreen(
                              isAdmin: userData.isAdmin,
                              priceString: _prices[1]['price'],
                            ))));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: customDrawer(
        userData: userData,
      ),
      body: (isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeImageSlider(),
                    SizedBox(height: 25),
                    Text(
                      "Last Updated (${_prices[4]['price']})",
                      style: textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    priceWidgetBox(
                      iconData: Icons.food_bank,
                      price: '${_prices[1]['price']}',
                      text: "Mustard (Sarso)",
                    ),
                    SizedBox(height: 25),
                    Text(
                      "Items Available",
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
                                    isAdmin: userData.isAdmin,
                                    priceString: _prices[1]['price'],
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
                                        data['productRating'],
                                        data['timeStamp'].toDate()),
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
