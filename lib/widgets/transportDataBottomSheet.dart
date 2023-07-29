import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';
import 'loading.dart';

class transportDataBottomSheet extends StatefulWidget {
  String factoryId;
  transportDataBottomSheet({super.key, required this.factoryId});

  @override
  State<transportDataBottomSheet> createState() => _transportDataBottomSheet();
}

class _transportDataBottomSheet extends State<transportDataBottomSheet> {
  String _partyName = "";
  String _truckNumber = "";
  String _driverName = "";
  String _driverNumber = "";
  String _ownerName = "";
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();

  DateTime _departureDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: (_isLoading)
          ? loading()
          : SafeArea(
              child: SingleChildScrollView(
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
                                  _partyName = val;
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
                              onChanged: (val) {
                                setState(() {
                                  _truckNumber = val;
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
                              onChanged: (val) {
                                setState(() {
                                  _driverName = val;
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
                              onChanged: (val) {
                                setState(() {
                                  _driverNumber = val;
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
                              onChanged: (val) {
                                setState(() {
                                  _ownerName = val;
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
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                Text(_departureDate.toString()),
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
                                  _addTransportData();
                                },
                                child: Text(
                                  "Upload",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      )),
                ),
              ),
            ),
    );
  }

  _addTransportData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .savingTransportData(
              _truckNumber,
              _driverName,
              _driverNumber,
              _ownerName,
              _partyName,
              FirebaseAuth.instance.currentUser!.uid,
              _departureDate,
              widget.factoryId)
          .whenComplete(() => _isLoading = false);
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
        _departureDate = value;
      });
    });
  }
}
