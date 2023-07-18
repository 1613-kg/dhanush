import 'package:dhanush/screens/loginScreen.dart';
import 'package:dhanush/services/authServices.dart';
import 'package:dhanush/widgets/itemsGrid.dart';
import 'package:flutter/material.dart';

import '../services/loginData.dart';
import '../widgets/customDrawer.dart';
import '../widgets/homeImageSlider.dart';
import '../widgets/priceWidgetBox.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String email = "";
  String userName = "";

  getUserData() async {
    await LoginData.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await LoginData.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dhanush"),
        backgroundColor: colorTheme,
      ),
      drawer: customDrawer(
        userName: userName,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeImageSlider(),
              SizedBox(height: 25),
              Text(
                "Live Price",
                style: textTheme.titleLarge,
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.pin_drop_sharp,
                price: "180/kg",
                text: "Mustard",
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.oil_barrel,
                price: "120/L",
                text: "Oil",
              ),
              SizedBox(
                height: 20,
              ),
              priceWidgetBox(
                iconData: Icons.cake,
                price: "500/kg",
                text: "Mustard Cake",
              ),
              SizedBox(height: 25),
              Text(
                "Items available",
                style: textTheme.titleLarge,
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: widht / height),
                  itemBuilder: (context, index) {
                    return itemsGrid();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
