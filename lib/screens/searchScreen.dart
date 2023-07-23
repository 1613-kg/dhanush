import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:dhanush/widgets/searchListView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';

class searchScreen extends StatefulWidget {
  searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController _searchController = TextEditingController();
  Stream? items;
  List<DocumentSnapshot> documents = [];

  getItemsData() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getItemsData()
        .then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemsData();
  }

  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              StreamBuilder(
                stream: items,
                builder: (ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return loading();
                  }

                  documents = snapshot.data.docs;

                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element
                          .get('titleName')
                          .toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();
                  }

                  return ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 2,
                        color: Colors.white,
                      );
                    },
                    itemBuilder: (context, index) {
                      final data = documents[index];
                      return searchListView(
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
                              data['productRating']));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
