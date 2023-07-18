import 'package:dhanush/widgets/homeImageSlider.dart';
import 'package:flutter/material.dart';

class itemDescScreen extends StatefulWidget {
  const itemDescScreen({super.key});

  @override
  State<itemDescScreen> createState() => _itemDescScreenState();
}

class _itemDescScreenState extends State<itemDescScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Item Name"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite_border_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
        ],
      ),
      body: SingleChildScrollView(
        child: (Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeImageSlider(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 8,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Brand Name"),
                        Text("price"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: widht,
                  height: height / 5,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Select Quantity"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                              CircleAvatar(
                                child: Text(((1 * 5).toString())),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {}, child: Text("Add Custom")),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 4,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: widht,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Add To Cart")),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: widht,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Buy Now")),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: widht,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Shop From Indiamart")),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: widht,
                  height: height / 4,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("About Product"),
                        Text("desc"),
                      ],
                    ),
                  ),
                ),
              ],
              // ),
            ))),
      ),
    );
  }
}
