import 'package:flutter/material.dart';

class transportDataBottomSheet extends StatefulWidget {
  transportDataBottomSheet({super.key});

  @override
  State<transportDataBottomSheet> createState() => _transportDataBottomSheet();
}

class _transportDataBottomSheet extends State<transportDataBottomSheet> {
  TextEditingController _partyNameController = TextEditingController();
  TextEditingController _truckNumberController = TextEditingController();
  TextEditingController _driverNameController = TextEditingController();
  TextEditingController _signedByController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();
  TextEditingController _driverNumberController = TextEditingController();

  DateTime _departureDate = DateTime.now();
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
                  controller: _truckNumberController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter vechicle number",
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
                  controller: _driverNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter driver name",
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
                  controller: _driverNumberController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter driver number",
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
                  controller: _ownerController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter vechile owner name",
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
                  controller: _signedByController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2))),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => datepicker(),
                        child: Text("Change departure date:")),
                    Text(_departureDate.toString()),
                  ],
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
