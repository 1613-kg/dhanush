import 'package:dhanush/model/transport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';
import 'loading.dart';

class transportDataUpdateBottomSheet extends StatefulWidget {
  TransportData transportData;
  transportDataUpdateBottomSheet({super.key, required this.transportData});

  @override
  State<transportDataUpdateBottomSheet> createState() =>
      _transportDataUpdateBottomSheetState();
}

class _transportDataUpdateBottomSheetState
    extends State<transportDataUpdateBottomSheet> {
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
                            initialValue: widget.transportData.deliveredTo,
                            onChanged: (val) {
                              setState(() {
                                widget.transportData.deliveredTo = val;
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
                                hintText: "Enter Party Name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.transportData.truckNumber,
                            onChanged: (val) {
                              setState(() {
                                widget.transportData.truckNumber = val;
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
                                hintText: "Enter vechicle number",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.transportData.driverName,
                            onChanged: (val) {
                              setState(() {
                                widget.transportData.driverName = val;
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
                                hintText: "Enter driver name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.transportData.driverContact,
                            onChanged: (val) {
                              setState(() {
                                widget.transportData.driverContact = val;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Field cannot be empty";
                              else
                                return null;
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: "Enter driver number",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: widget.transportData.owner,
                            onChanged: (val) {
                              setState(() {
                                widget.transportData.owner = val;
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
                                hintText: "Enter vechile owner name",
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
                              InkWell(
                                  onTap: () => datepicker(),
                                  child: Text(
                                    "Change departure date:",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )),
                              Text(widget.transportData.leavingTime.toString()),
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
                              _updateTransportData();
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

  _updateTransportData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .updatingTransportData(widget.transportData)
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Updated Successfully");
    }
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: widget.transportData.leavingTime,
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        widget.transportData.leavingTime = value;
      });
    });
  }
}
