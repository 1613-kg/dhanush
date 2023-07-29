import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/model/orderData.dart';
import 'package:dhanush/model/userData.dart';
import 'package:dhanush/widgets/orderAdminWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/customDrawer.dart';
import '../widgets/loading.dart';

class allOrders extends StatefulWidget {
  allOrders({super.key});

  @override
  State<allOrders> createState() => _allOrdersState();
}

class _allOrdersState extends State<allOrders> {
  Stream? orders;
  UserData userData = UserData('id', 'email', 'userName', false, 'password',
      'profilePic', ['isFav'], ['isAddedToCart']);

  getAllOrdersData() async {
    await DatabaseServices(
      FirebaseAuth.instance.currentUser!.uid,
    ).getAllOrders().then((snapshots) {
      setState(() {
        orders = snapshots;
      });
    });
  }

  getUser() async {
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingUserIdData();

    setState(() {
      userData.id = snapshot.docs[0]['uid'];
      userData.email = snapshot.docs[0]['email'];
      userData.userName = snapshot.docs[0]['userName'];
      userData.isAdmin = snapshot.docs[0]['isAdmin'];
      userData.isAddedToCart = snapshot.docs[0]['isAddedToCart'];
      userData.isFav = snapshot.docs[0]['isFav'];
      userData.profilePic = snapshot.docs[0]['profilePic'];
      userData.password = snapshot.docs[0]['password'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOrdersData();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: customDrawer(
        userData: userData,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: orders,
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var dataList = snapshot.data.docs;
              // if (snapshot.data['stocks'] != null) {
              if (dataList.length != 0) {
                return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: ((context, index) {
                      final data = dataList[index].data();
                      return orderAdminWidget(
                          orderData: OrderData(
                              orderId: data['orderId'],
                              address: data['address'],
                              itemId: data['itemId'],
                              buyerId: data['buyerId'],
                              date: data['date'].toDate(),
                              paymentType: data['paymentType'],
                              price: data['price'],
                              quantity: data['quantity']),
                          userName: userData.userName);
                    }));
              } else
                return Container();
              // } else
              //   return Container();
            } else
              return loading();
          }),
        ),
      ),
    );
  }
}
