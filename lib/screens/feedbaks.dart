import 'package:dhanush/constants.dart';
import 'package:dhanush/model/feedback.dart';
import 'package:dhanush/model/itemsData.dart';
import 'package:dhanush/screens/homeScreen.dart';
import 'package:dhanush/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../services/databaseServices.dart';

class feedbacks extends StatefulWidget {
  ItemsData itemsData;
  feedbacks({super.key, required this.itemsData});

  @override
  State<feedbacks> createState() => _feedbacksState();
}

class _feedbacksState extends State<feedbacks> {
  TextEditingController _feedbackController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double rating = 0;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      this.showRatingBar();
    });
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Feedback",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: widht / 2,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: LinearBorder(), backgroundColor: colorTheme),
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                        (route) => false);
                  },
                  child: Text(
                    "Later",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: widht / 2,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: LinearBorder(), backgroundColor: colorTheme),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await DatabaseServices(
                              FirebaseAuth.instance.currentUser!.uid)
                          .savingFeedbackData(FeedbackData(
                              feedbackId: '',
                              content: _feedbackController.text,
                              givenBy: '',
                              submitDate: DateTime.now()))
                          .whenComplete(() {
                        setState(() {
                          isLoading = false;
                        });
                        showSnackbar(context, Colors.green,
                            "Feedback submitted successfully");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
                            (route) => false);
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: (isLoading)
          ? loading()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Container(
                  height: height,
                  width: widht,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send your love to us!",
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _feedbackController.text = value;
                            });
                          },
                          showCursor: true,
                          maxLines: 5,
                          controller: _feedbackController,
                          decoration: InputDecoration(
                              hintText: "Write feedback....",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: colorTheme)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: colorTheme),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              border: InputBorder.none),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Feedback can not be empty";
                            } else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height / 1.8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  showRatingBar() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rating"),
          content: RatingBar(
              initialRating: 0,
              minRating: 0,
              maxRating: 5,
              allowHalfRating: true,
              itemSize: 40,
              wrapAlignment: WrapAlignment.center,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Color.fromARGB(234, 235, 105, 45),
                ),
                half: Icon(
                  Icons.star_half,
                  color: Color.fromARGB(234, 235, 105, 45),
                ),
                empty: Icon(
                  Icons.star_border,
                  color: Color.fromARGB(234, 235, 105, 45),
                ),
              ),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                  widget.itemsData.productRating =
                      ((widget.itemsData.productRating + rating) / 2) % 5;
                });
              }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Remind me later",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseServices(FirebaseAuth.instance.currentUser!.uid)
                    .updatingItemRating(widget.itemsData)
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
