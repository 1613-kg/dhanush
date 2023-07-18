import 'package:flutter/material.dart';

class addItemScreen extends StatefulWidget {
  const addItemScreen({super.key});

  @override
  State<addItemScreen> createState() => _addItemScreenState();
}

class _addItemScreenState extends State<addItemScreen> {
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _itemDescController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Card(
            //elevation: 5,
            child: Container(
                padding: EdgeInsets.all(10),
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
                    TextField(
                      // onSubmitted: (val) {
                      //   _nameController.text = val;
                      // },
                      controller: _itemNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter item name",
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
                      controller: _brandController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Brand",
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
                      controller: _priceController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Price",
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
                      controller: _quantityController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter packaging quantity",
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
                      controller: _unitController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter item unit",
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
                      controller: _itemDescController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter about item",
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
        ),
      ),
    );
  }
}
