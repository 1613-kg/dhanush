import 'package:flutter/material.dart';

class feedbacks extends StatefulWidget {
  const feedbacks({super.key});

  @override
  State<feedbacks> createState() => _feedbacksState();
}

class _feedbacksState extends State<feedbacks> {
  TextEditingController _feedbackController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            width: widht,
            child: Column(
              children: [
                Text("Send Feedback"),
                Text("Send your love to us!"),
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
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: Text("Submit Feedback")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
