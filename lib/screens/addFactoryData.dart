import 'package:dhanush/model/factoryData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class addFactoryData extends StatefulWidget {
  const addFactoryData({super.key});

  @override
  State<addFactoryData> createState() => _addFactoryDataState();
}

class _addFactoryDataState extends State<addFactoryData> {
  String description = "";
  String location = "";
  String name = "";
  List<String> imageUrl = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Factory Data"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Card(
            //elevation: 5,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/logoDhanush.jpg",
                          height: height / 5,
                          width: widht,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Enter factory name",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          location = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Enter factory location",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          description = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        maxLines: 5,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "About...",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                              _addFactoryData();
                            },
                            child: Text("Upload")),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  _addFactoryData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .savingFactoryData(FactoryData(
              '', location, description, imageUrl, name, [], [], []))
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Uploaded Successfully");
    }
  }
}
