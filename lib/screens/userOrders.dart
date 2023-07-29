import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/orderData.dart';
import 'package:dhanush/widgets/customDrawer.dart';
import 'package:dhanush/widgets/orderWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userData.dart';
import '../services/databaseServices.dart';
import '../widgets/loading.dart';

class userOrder extends StatefulWidget {
  const userOrder({super.key});

  @override
  State<userOrder> createState() => _userOrderState();
}

class _userOrderState extends State<userOrder> {
  Stream? orders;
  UserData userData = UserData('id', 'email', 'userName', false, 'password',
      'profilePic', ['isFav'], ['isAddedToCart']);

  getOrderData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getOrdersData()
        .then((value) {
      setState(() {
        orders = value;
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
    getOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Your Orders",
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
      body: StreamBuilder(
        stream: orders,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var dataList = snapshot.data.docs;
              if (dataList.length != 0) {
                return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemBuilder: ((context, index) {
                      final data = dataList[index];
                      return orderWidget(
                        orderData: OrderData(
                            orderId: data['orderId'],
                            address: data['address'],
                            itemId: data['itemId'],
                            buyerId: data['buyerId'],
                            date: data['date'].toDate(),
                            paymentType: data['paymentType'],
                            price: data['price'],
                            quantity: data['quantity']),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    }),
                    itemCount: dataList.length);
              } else
                return Container();
            } else
              return Container();
          } else
            return loading();
        }),
      ),
    );
  }
}
