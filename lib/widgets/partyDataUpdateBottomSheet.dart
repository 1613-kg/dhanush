import 'package:dhanush/model/partyData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class partyDataUpdateBottomSheet extends StatefulWidget {
  PartyData partyData;
  partyDataUpdateBottomSheet({super.key, required this.partyData});

  @override
  State<partyDataUpdateBottomSheet> createState() =>
      _partyDataUpdateBottomSheetState();
}

class _partyDataUpdateBottomSheetState
    extends State<partyDataUpdateBottomSheet> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
                      initialValue: widget.partyData.partyName,
                      onChanged: (val) {
                        setState(() {
                          widget.partyData.partyName = val;
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
                      initialValue: widget.partyData.partyLocation,
                      onChanged: (val) {
                        setState(() {
                          widget.partyData.partyLocation = val;
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
                      initialValue: widget.partyData.paymentLeft,
                      onChanged: (val) {
                        setState(() {
                          widget.partyData.paymentLeft = val;
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
                      initialValue: widget.partyData.paymentDone,
                      onChanged: (val) {
                        setState(() {
                          widget.partyData.paymentDone = val;
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
                          _updatePartyData();
                        },
                        child: Text("Update")),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  _updatePartyData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .updatingPartyData(widget.partyData)
          .whenComplete(() => isLoading = false);
      Navigator.pop(context);
      showSnackbar(context, Colors.green, "Data Updated Successfully");
    }
  }
}
