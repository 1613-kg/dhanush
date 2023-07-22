import 'dart:io';

import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/services/authServices.dart';
import 'package:dhanush/widgets/imageSlider.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../services/databaseServices.dart';

class addFactoryData extends StatefulWidget {
  const addFactoryData({super.key});

  @override
  State<addFactoryData> createState() => _addFactoryDataState();
}

class _addFactoryDataState extends State<addFactoryData> {
  String description = "";
  String location = "";
  String name = "";
  List<File> _image = [];
  List<String> _imageUrl = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Factory Data"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: (isLoading)
            ? loading()
            : Container(
                height: height,
                child: Card(
                  shape: LinearBorder(),
                  //elevation: 5,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Container(
                            //   child: Image.asset(
                            //     "assets/images/logoDhanush.jpg",
                            //     height: height / 5,
                            //     width: widht,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),

                            TextFormField(
                              onChanged: (val) {
                                name = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Field cannot be empty";
                                else
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: "Enter factory name",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onChanged: (val) {
                                location = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Field cannot be empty";
                                else
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: "Enter factory location",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onChanged: (val) {
                                description = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Field cannot be empty";
                                else
                                  return null;
                              },
                              maxLines: 5,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: "About...",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Images",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            GridView.builder(
                              itemCount: _image.length + 1,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: ((context, index) {
                                return (index == 0)
                                    ? Center(
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black38,
                                                  width: 1)),
                                          child: IconButton(
                                              onPressed: () {
                                                showDialogOpt(context);
                                              },
                                              icon: Icon(Icons.add)),
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
                                                    showSnackbar(
                                                        context,
                                                        Colors.red,
                                                        "Removed image at ${index}");
                                                    _image.removeAt(index - 1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  size: 35,
                                                  color: Colors.red,
                                                ),
                                              )),
                                        ],
                                      );
                              }),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _addFactoryData();
                                    },
                                    child: Text("Upload")),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
      ),
    );
  }

  _addFactoryData() async {
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
        AuthService().uploadFactoryPictures(_image).then((value) {
          setState(() {
            _imageUrl = value;
          });
          DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
              .savingFactoryData(FactoryData(
                  '', location, description, _imageUrl, name, [], [], []))
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
        //File compressedImage = await customCompressed(image);
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
