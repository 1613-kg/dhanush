import 'package:dhanush/model/stockData.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class stockDataUpdateBottomSheet extends StatefulWidget {
  StockData stockData;
  stockDataUpdateBottomSheet({super.key, required this.stockData});

  @override
  State<stockDataUpdateBottomSheet> createState() =>
      _stockDataUpdateBottomSheetState();
}

class _stockDataUpdateBottomSheetState
    extends State<stockDataUpdateBottomSheet> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
                            initialValue: widget.stockData.type,
                            onChanged: (val) {
                              setState(() {
                                widget.stockData.type = val;
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
                            initialValue: widget.stockData.stock,
                            onChanged: (val) {
                              setState(() {
                                widget.stockData.stock = val;
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
                            initialValue: widget.stockData.buyingParty,
                            onChanged: (val) {
                              setState(() {
                                widget.stockData.buyingParty = val;
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
                                  value: widget.stockData.labCheck,
                                  onChanged: (val) {
                                    setState(() {
                                      widget.stockData.labCheck = val;
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
                              Text(widget.stockData.buyingDate.toString()),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {
                              _updateStockData();
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
    );
  }

  _updateStockData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .updatingStockData(widget.stockData)
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Updated Successfully");
    }
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: widget.stockData.buyingDate,
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        widget.stockData.buyingDate = value;
      });
    });
  }
}
