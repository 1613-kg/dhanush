import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanush/model/feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/userData.dart';
import '../services/databaseServices.dart';

class feedbackWidget extends StatefulWidget {
  FeedbackData feedbackData;
  feedbackWidget({super.key, required this.feedbackData});

  @override
  State<feedbackWidget> createState() => _feedbackWidgetState();
}

class _feedbackWidgetState extends State<feedbackWidget> {
  UserData userData = UserData('id', 'email', 'userName', false, 'password',
      'profilePic', ['isFav'], ['isAddedToCart']);

  getUser() async {
    QuerySnapshot snapshot =
        await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
            .gettingUserIdData();

    setState(() {
      userData.id = snapshot.docs[0]['uid'];
      userData.email = snapshot.docs[0]['email'];
      userData.userName = snapshot.docs[0]['userName'];
      userData.isAdmin = snapshot.docs[0]['isAdmin'];
      userData.isAddedToCart = snapshot.docs[0]['isAddedToCart'].cast<String>();
      userData.isFav = snapshot.docs[0]['isFav'].cast<String>();
      userData.profilePic = snapshot.docs[0]['profilePic'];
      userData.password = snapshot.docs[0]['password'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: AutoSizeText(
                widget.feedbackData.content,
                style: textTheme.bodyMedium,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Submitted By: ${userData.userName}(${userData.email})",
              style: textTheme.bodySmall,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Submitted On: ${DateFormat.yMd().format(widget.feedbackData.submitDate)}",
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
