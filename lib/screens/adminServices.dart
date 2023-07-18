import 'package:dhanush/model/factoryData.dart';
import 'package:dhanush/screens/addItemScreen.dart';
import 'package:dhanush/widgets/factoryExpansionTile.dart';
import 'package:flutter/material.dart';

import 'factoryDetailsScreen.dart';

class adminServices extends StatefulWidget {
  String userName;
  adminServices({super.key, required this.userName});

  @override
  State<adminServices> createState() => _adminServicesState();
}

class _adminServicesState extends State<adminServices> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    var textTheme = Theme.of(context).primaryTextTheme;
    var colorTheme = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        backgroundColor: colorTheme,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: CircleAvatar(
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addItemScreen()));
              },
              icon: Icon(
                Icons.add,
              )),
          radius: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.account_circle,
                size: 250,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.userName),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Password",
                      style: textTheme.bodySmall,
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Change",
                          style: TextStyle(color: Colors.purpleAccent),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              factoryExpansionTile(
                factoryData: FactoryData(
                    "id", "Bharatpur", "", "", "Garg Oil", 0, 0, [], [], []),
              ),
              SizedBox(
                height: 20,
              ),
              factoryExpansionTile(
                factoryData: FactoryData(
                    "id", "Bharatpur", "", "", "Garg Oil", 0, 0, [], [], []),
              ),
              SizedBox(
                height: 20,
              ),
              factoryExpansionTile(
                factoryData: FactoryData(
                    "id", "Bharatpur", "", "", "Garg Oil", 0, 0, [], [], []),
              ),
              SizedBox(
                height: 20,
              ),
              factoryExpansionTile(
                factoryData: FactoryData(
                    "id", "Bharatpur", "", "", "Garg Oil", 0, 0, [], [], []),
              ),
              SizedBox(
                height: 20,
              ),
              factoryExpansionTile(
                factoryData: FactoryData(
                    "id", "Bharatpur", "", "", "Garg Oil", 0, 0, [], [], []),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
