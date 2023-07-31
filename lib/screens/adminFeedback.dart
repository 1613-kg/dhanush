import 'package:dhanush/model/feedback.dart';
import 'package:dhanush/widgets/feedbackWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/databaseServices.dart';
import '../widgets/loading.dart';

class adminFeedback extends StatefulWidget {
  const adminFeedback({super.key});

  @override
  State<adminFeedback> createState() => _adminFeedbackState();
}

class _adminFeedbackState extends State<adminFeedback> {
  Stream? feedback;

  getAllFeedbacks() async {
    await DatabaseServices(
      FirebaseAuth.instance.currentUser!.uid,
    ).getAllFeedbacks().then((snapshots) {
      setState(() {
        feedback = snapshots;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Customer Feedbacks",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: feedback,
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var dataList = snapshot.data.docs;
              // if (snapshot.data['stocks'] != null) {
              if (dataList.length != 0) {
                return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: ((context, index) {
                      final data = dataList[index].data();
                      return feedbackWidget(
                          feedbackData: FeedbackData(
                              feedbackId: data['feedbackId'],
                              content: data['content'],
                              givenBy: data['givenBy'],
                              submitDate: data['submitDate'].toDate()));
                    }));
              } else
                return Container();
              // } else
              //   return Container();
            } else
              return loading();
          }),
        ),
      ),
    );
  }
}
