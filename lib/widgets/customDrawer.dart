import 'package:dhanush/model/userData.dart';
import 'package:dhanush/screens/aboutUsWebView.dart';
import 'package:dhanush/screens/adminFeedback.dart';
import 'package:dhanush/screens/adminServices.dart';
import 'package:dhanush/screens/allOrders.dart';
import 'package:dhanush/screens/facebook.dart';
import 'package:dhanush/screens/favouritesScreen.dart';

import 'package:dhanush/screens/homeScreen.dart';
import 'package:dhanush/screens/instagram.dart';
import 'package:dhanush/screens/profile.dart';
import 'package:dhanush/screens/userFeedback.dart';

import 'package:dhanush/screens/userOrders.dart';
import 'package:flutter/material.dart';
import 'package:social_media_flutter/widgets/icons.dart';

import '../screens/loginScreen.dart';
import '../services/authServices.dart';

class customDrawer extends StatelessWidget {
  UserData userData;
  customDrawer({required this.userData});

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Drawer(
      elevation: 1,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorTheme,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black54, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userData.userName.toUpperCase(),
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              focusColor: colorTheme,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                    (route) => false);
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.home),
              title: Text("Home", style: textTheme.bodyLarge),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile(
                            userData: userData,
                          )),
                );
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.person),
              title: Text(
                "Profile",
                style: textTheme.bodyLarge,
              ),
            ),
            (!userData.isAdmin)
                ? ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => userOrder()),
                          (route) => false);
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.wallet_travel_sharp),
                    title: Text(
                      "Order History",
                      style: textTheme.bodyLarge,
                    ),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => allOrders()),
                          (route) => false);
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.wallet_travel_sharp),
                    title: Text(
                      "Order Details",
                      style: textTheme.bodyLarge,
                    ),
                  ),
            (!userData.isAdmin)
                ? ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => userFeedback()),
                      );
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.feedback_outlined),
                    title: Text(
                      "My Feedbacks",
                      style: textTheme.bodyLarge,
                    ),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => adminFeedback()),
                      );
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.feedback),
                    title: Text(
                      "Customer Feedbacks",
                      style: textTheme.bodyLarge,
                    ),
                  ),
            (userData.isAdmin)
                ? ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adminServices(
                                    userData: userData,
                                  )));
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.privacy_tip),
                    title: Text(
                      "Admin Services",
                      style: textTheme.bodyLarge,
                    ),
                  )
                : Container(),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aboutUsWebView()));
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.info),
              title: Text(
                "About us",
                style: textTheme.bodyLarge,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => loginScreen()),
                                  (route) => false);
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      );
                    });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: textTheme.bodyLarge,
              ),
            ),
            (userData.isAdmin)
                ? SizedBox(
                    height: 90,
                  )
                : SizedBox(
                    height: 150,
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Follow Us: ",
                    style: textTheme.bodyLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => facebok()));
                          },
                          icon: Icon(SocialIconsFlutter.facebook)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => instagram()));
                          },
                          icon: Icon(SocialIconsFlutter.instagram)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
