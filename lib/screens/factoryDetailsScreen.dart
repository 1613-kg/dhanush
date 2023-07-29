import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/widgets/factoryDetailsWidget.dart';
import 'package:flutter/material.dart';

import '../widgets/imageSlider.dart';

class factoryDetailsScreen extends StatelessWidget {
  FactoryData factoryData;
  factoryDetailsScreen({super.key, required this.factoryData});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    final data = factoryData;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          factoryData.name[0].toUpperCase() + data.name.substring(1),
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
        child: Column(
          children: [
            imageSlider(images: data.imageUrl),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  factoryDetailsWidget(title: "Name", content: "${data.name}"),
                  SizedBox(
                    height: 20,
                  ),
                  factoryDetailsWidget(
                      title: "Location", content: "${data.location}"),
                  SizedBox(
                    height: 20,
                  ),
                  factoryDetailsWidget(
                      title: "About", content: "${data.description}"),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
