import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/model/userData.dart';
import 'package:flutter/material.dart';

import '../widgets/myProfileInfo.dart';

class profile extends StatelessWidget {
  UserData userData;
  profile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
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
                height: 250,
                width: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 80,
                ),
                filterQuality: FilterQuality.high,
                imageUrl: userData.profilePic,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    // showDialogOpt(context, data['profilePic']);
                    // // final ap = Provider.of<AuthProvider>(context,
                    // //     listen: false);
                    // // await ap.updateProPic(img,data['profilePic']);
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
                title: "Username : ${userData.userName}",
              ),
              SizedBox(
                height: 15,
              ),
              myProfileInfo(
                icon: Icons.email,
                title: "Email : ${userData.email}",
              ),
              SizedBox(
                height: 15,
              ),
              myProfileInfo(
                  icon: Icons.admin_panel_settings,
                  title: "Status: ${(userData.isAdmin) ? "Admin" : "User"}"),
            ],
          ),
        ),
      ),
    );
  }
}
