import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class partyDataBottomSheet extends StatefulWidget {
  String factoryId;
  partyDataBottomSheet({super.key, required this.factoryId});

  @override
  State<partyDataBottomSheet> createState() => _partyDataBottomSheet();
}

class _partyDataBottomSheet extends State<partyDataBottomSheet> {
  String _partyName = "";
  String _partyLocation = "";
  String _paymentLeft = "";
  String _paymentDone = "";
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          _partyLocation = val;
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
                          hintText: "Enter Party Location",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          _paymentLeft = val;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Payment Left",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          _paymentDone = val;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: "Enter payment done",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _addPartyData();
                        },
                        child: Text("Upload"))
                  ],
                ),
              )),
        ),
      ),
    );
  }

  _addPartyData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .savingPartyData(_partyName, _partyLocation, _paymentLeft,
              _paymentDone, widget.factoryId)
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Uploaded Successfully");
    }
  }
}
