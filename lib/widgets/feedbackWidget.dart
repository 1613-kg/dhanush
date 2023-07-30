import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanush/model/feedback.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class feedbackWidget extends StatelessWidget {
  FeedbackData feedbackData;
  feedbackWidget({super.key, required this.feedbackData});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Submitted By: ${feedbackData.givenBy}",
            style: textTheme.bodyMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Submitted On: ${DateFormat.yMd().format(feedbackData.submitDate)}",
            style: textTheme.bodyMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: colorTheme, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: AutoSizeText(
              feedbackData.givenBy,
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
