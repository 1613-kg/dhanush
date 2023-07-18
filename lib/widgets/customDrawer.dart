import 'package:dhanush/screens/adminServices.dart';
import 'package:dhanush/screens/feedbaks.dart';
import 'package:dhanush/screens/homeScreen.dart';
import 'package:dhanush/screens/profile.dart';
import 'package:dhanush/screens/settings.dart';
import 'package:flutter/material.dart';

import '../screens/loginScreen.dart';
import '../services/authServices.dart';

class customDrawer extends StatefulWidget {
  String userName;
  customDrawer({super.key, required this.userName});

  @override
  State<customDrawer> createState() => _customDrawerState();
}

class _customDrawerState extends State<customDrawer> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Drawer(
      elevation: 1,
      child: ListView(
        children: [
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.userName,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.group),
            title: Text("Home", style: textTheme.bodyLarge),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
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
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => feedbacks()));
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.feedback),
            title: Text(
              "Feedbacks",
              style: textTheme.bodyLarge,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => adminServices(
                            userName: widget.userName,
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
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => settings()));
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.settings),
            title: Text(
              "Settings",
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
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => loginScreen()),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
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
        ],
      ),
    );
  }
}
