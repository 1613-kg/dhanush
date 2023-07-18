import 'package:flutter/material.dart';

class partyDataBottomSheet extends StatefulWidget {
  partyDataBottomSheet({super.key});

  @override
  State<partyDataBottomSheet> createState() => _partyDataBottomSheet();
}

class _partyDataBottomSheet extends State<partyDataBottomSheet> {
  TextEditingController _partyNameController = TextEditingController();
  TextEditingController _partyLocationController = TextEditingController();
  TextEditingController _paymentLeftController = TextEditingController();
  TextEditingController _paymentDoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Card(
        //elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  // onSubmitted: (val) {
                  //   _nameController.text = val;
                  // },
                  controller: _partyNameController,
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
                TextField(
                  // onSubmitted: (val) {
                  //   _emailController.text = val;
                  // },
                  controller: _partyLocationController,
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
                TextField(
                  // onSubmitted: (val) {
                  //   _categoryController.text = val;
                  // },
                  controller: _paymentLeftController,
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
                TextField(
                  // onSubmitted: (val) {
                  //   _contactController.text = val;
                  // },
                  controller: _paymentDoneController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter payment done",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2))),
                ),

                SizedBox(
                  height: 25,
                ),
                //(widget.data.id == null)
                ElevatedButton(onPressed: () {}, child: Text("Upload"))
                // : ElevatedButton(
                //     onPressed: () {
                //       setState(() {

                //     },
                //     child: Text("Update")),
                //     }
                // )
              ],
            )),
      ),
    );
  }
}
