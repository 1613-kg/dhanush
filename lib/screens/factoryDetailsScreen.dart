import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanush/model/factoryData.dart';
import 'package:flutter/material.dart';

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
        title: Text(data.name),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                height: height / 4,
                width: widht,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 150,
                ),
                //radius: 150,
                imageUrl:
                    "https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9",
              ),
              Positioned(
                  bottom: 10,
                  left: 20,
                  child: Column(
                    children: [Text(data.name), Text(data.location)],
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
            color: Colors.redAccent,
            indent: 30,
            endIndent: 30,
          ),
          SizedBox(
            height: 30,
          ),
          Text(data.description),
        ],
      ),
    );
  }
}
