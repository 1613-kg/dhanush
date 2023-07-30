import 'package:dhanush/model/feedback.dart';
import 'package:dhanush/widgets/feedbackWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';

class userFeedback extends StatefulWidget {
  const userFeedback({super.key});

  @override
  State<userFeedback> createState() => _userFeedbackState();
}

class _userFeedbackState extends State<userFeedback> {
  Stream? feedback;

  getFeedback() async {
    await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
        .getUserFeedbacks()
        .then((value) {
      setState(() {
        feedback = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "My Feedbacks",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: feedback,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var dataList = snapshot.data.docs;
              if (dataList.length != 0) {
                return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemBuilder: ((context, index) {
                      final data = dataList[index];
                      return feedbackWidget(
                          feedbackData: FeedbackData(
                              feedbackId: data['feedbackId'],
                              content: data['content'],
                              givenBy: data['givenBy'],
                              submitDate: data['submitDate'].toDate()));
                    }),
                    separatorBuilder: ((context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    }),
                    itemCount: dataList.length);
              } else
                return Container();
            } else
              return Container();
          } else
            return loading();
        }),
      ),
    );
  }
}
