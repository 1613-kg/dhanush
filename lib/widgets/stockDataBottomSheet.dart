import 'package:dhanush/constants.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class stockDataBottomSheet extends StatefulWidget {
  String factoryId;
  stockDataBottomSheet({super.key, required this.factoryId});

  @override
  State<stockDataBottomSheet> createState() => _stockDataBottomSheetState();
}

class _stockDataBottomSheetState extends State<stockDataBottomSheet> {
  String _type = "";
  String _amount = "";
  String _purchasedFrom = "";
  bool _labChecked = false;
  bool isLoading = false;
  DateTime _purchasedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: (isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Card(
                //elevation: 5,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                _type = val;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Field cannot be empty";
                              else
                                return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: "Enter Stock type",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                _amount = val;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Field cannot be empty";
                              else
                                return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: "Enter amount",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                _purchasedFrom = val;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Field cannot be empty";
                              else
                                return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: "Enter Purchasing Party",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lab Check"),
                              Switch(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: _labChecked,
                                  onChanged: (val) {
                                    setState(() {
                                      _labChecked = val;
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () => datepicker(),
                                  child: Text(
                                    "Change date:",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )),
                              Text(_purchasedDate.toString()),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //(widget.data.id == null)
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () {
                                _addStockData();
                              },
                              child: Text(
                                "Upload",
                                style: TextStyle(color: Colors.white),
                              ))
                          // : ElevatedButton(
                          //     onPressed: () {
                          //       setState(() {

                          //     },
                          //     child: Text("Update")),
                          //     }
                          // )
                        ],
                      ),
                    )),
              ),
            ),
    );
  }

  _addStockData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .savingStockData(_type, _amount, _purchasedFrom, _labChecked,
              _purchasedDate, widget.factoryId)
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Uploaded Successfully");
    }
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _purchasedDate = value;
      });
    });
  }
}
