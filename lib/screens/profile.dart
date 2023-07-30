import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/constants.dart';
import 'package:dhanush/model/userData.dart';
import 'package:dhanush/services/authServices.dart';
import 'package:dhanush/services/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/myProfileInfo.dart';

class profile extends StatefulWidget {
  UserData userData;
  profile({super.key, required this.userData});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String profile = "";
  File? img;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            children: [
              CachedNetworkImage(
                height: height / 4,
                width: widht / 1.5,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 80,
                ),
                filterQuality: FilterQuality.high,
                imageUrl:
                    (profile == "") ? widget.userData.profilePic : profile,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    showDialogOpt(context);
                    if (img != null) {
                      await AuthService().uploadProPic(img).then((value) async {
                        setState(() {
                          profile = value;
                        });
                        await DatabaseServices(
                                FirebaseAuth.instance.currentUser!.uid)
                            .updateProfile(profile);
                      });
                    }
                  },
                  child: Text(
                    "Change Profile",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
              Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              myProfileInfo(
                icon: Icons.person,
                title: "Username : ${widget.userData.userName}",
              ),
              SizedBox(
                height: 15,
              ),
              myProfileInfo(
                icon: Icons.email,
                title: "Email : ${widget.userData.email}",
              ),
              SizedBox(
                height: 15,
              ),
              myProfileInfo(
                  icon: Icons.admin_panel_settings,
                  title:
                      "Status: ${(widget.userData.isAdmin) ? "Admin" : "User"}"),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage(ImageSource src, BuildContext context) async {
    final file = await ImagePicker().pickImage(source: src);
    File image = File(file!.path);
    File compressedImage = await customCompressed(image);

    setState(() {
      img = compressedImage;
    });
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
                    pickImage(ImageSource.camera, context);
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
                    pickImage(ImageSource.gallery, context);
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
                  onPressed: () async {
                    (widget.userData.profilePic == "")
                        ? Navigator.pop(context)
                        : deleteProfile();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(
                        width: 20,
                      ),
                      Text((widget.userData.profilePic == "")
                          ? "Close"
                          : "Remove"),
                    ],
                  ),
                )
              ],
            ));
  }

  deleteProfile() async {
    await AuthService().deleteProPic().whenComplete(() async {
      await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
          .updateProfile("");
      Navigator.pop(context);
      showSnackbar(context, Colors.red, "Profile picture removed");
    });
  }
}
