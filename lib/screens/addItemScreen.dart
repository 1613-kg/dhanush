import 'dart:io';

import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../services/authServices.dart';
import '../services/databaseServices.dart';

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
  List<File> _image = [];
  List<String> _imageUrl = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var colorTheme = Theme.of(context).primaryColor;
    var textTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Add Item",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: (isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Item Name",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                              hint: "Bottle",
                              inputType: TextInputType.multiline,
                              controller: _itemNameController,
                              maxLine: 1,
                              color: colorTheme),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Brand",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                            hint: "Dhanush",
                            inputType: TextInputType.multiline,
                            controller: _brandController,
                            maxLine: 1,
                            color: colorTheme,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                            hint: "15 L",
                            inputType: TextInputType.multiline,
                            controller: _quantityController,
                            maxLine: 1,
                            color: colorTheme,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Item Unit",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                            hint: "Litre",
                            inputType: TextInputType.multiline,
                            controller: _unitController,
                            maxLine: 1,
                            color: colorTheme,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Item Description",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                            hint: "This product is good for health...",
                            inputType: TextInputType.multiline,
                            controller: _itemDescController,
                            maxLine: 4,
                            color: colorTheme,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Images",
                        style: textTheme.titleLarge,
                      ),
                      GridView.builder(
                        itemCount: _image.length + 1,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: ((context, index) {
                          return (index == 0)
                              ? Center(
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    child: IconButton(
                                        onPressed: () {
                                          showDialogOpt(context);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: colorTheme,
                                        )),
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Positioned(
                                      top: 25,
                                      right: 25,
                                      child: Container(
                                        height: 95,
                                        width: 95,
                                        child: Image.file(
                                          _image[index - 1],
                                          height: 95,
                                          width: 95,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            showSnackbar(context, Colors.red,
                                                "Removed image at ${index}");
                                            _image.removeAt(index - 1);
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 35,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorTheme),
                              onPressed: () {
                                _addItemsData();
                              },
                              child: Text(
                                "Upload",
                                style: TextStyle(color: Colors.white),
                              ))),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget textField({
    required String hint,
    required TextInputType inputType,
    required TextEditingController controller,
    required int maxLine,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TextFormField(
        validator: (val) {
          if (val!.isNotEmpty) {
            return null;
          } else {
            return "Field cannot be empty";
          }
        },
        maxLines: maxLine,
        cursorColor: color,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).primaryTextTheme.bodyMedium,
            //helperText: titleText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: color)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color),
            ),
            border: InputBorder.none),
      ),
    );
  }

  _addItemsData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (_image == null || _image.length == 0) {
        showSnackbar(context, Colors.red, "Please upload 1 or more images");
        setState(() {
          isLoading = false;
        });
      } else {
        DateTime timeStamp = DateTime.now();
        AuthService()
            .uploadItemPictures(
          _image,
          timeStamp,
          _itemNameController.text,
        )
            .then((value) {
          setState(() {
            _imageUrl = value;
          });
          DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
              .savingItemsData(ItemsData(
                  _brandController.text,
                  _itemDescController.text,
                  "",
                  int.parse(_quantityController.text),
                  _itemNameController.text,
                  _priceController.text,
                  _imageUrl,
                  [],
                  [],
                  "",
                  0.0,
                  timeStamp))
              .whenComplete(() => isLoading = false);
          Navigator.pop(context);
          showSnackbar(context, Colors.green, "Data Uploaded Successfully");
        });
      }
    }
  }

  void pickImage(BuildContext context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(file!.path);
    //File compressedImage = await customCompressed(image);
    setState(() {
      _image.add(image);
    });
  }

  void pickMultipleImage(BuildContext context) async {
    final file = await ImagePicker().pickMultiImage();
    for (int i = 0; i < file.length; i++) {
      if (file[i] != null) {
        File image = File(file[i].path);
        // File compressedImage = await customCompressed(image);
        setState(() {
          _image.add(image);
        });
      }
    }
  }

  Future<File> customCompressed(File imagePath) async {
    var path = await FlutterNativeImage.compressImage(imagePath.absolute.path,
        quality: 100, percentage: 10);
    return path;
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    pickImage(context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Camera"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    pickMultipleImage(context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.album),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Close"),
                    ],
                  ),
                )
              ],
            ));
  }
}
