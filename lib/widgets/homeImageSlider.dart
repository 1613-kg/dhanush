import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class homeImageSlider extends StatefulWidget {
  const homeImageSlider({super.key});

  @override
  State<homeImageSlider> createState() => _homeImageSliderState();
}

class _homeImageSliderState extends State<homeImageSlider> {
  List<Widget> item = [
    Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(234, 235, 105, 45).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          'assets/images/image1.png',
          fit: BoxFit.cover,
          width: double.infinity,
        )),
    Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(234, 235, 105, 45).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          'assets/images/image2.png',
          fit: BoxFit.cover,
          width: double.infinity,
        )),
    Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(234, 235, 105, 45).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          'assets/images/image3.png',
          fit: BoxFit.cover,
          width: double.infinity,
        )),
    Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(234, 235, 105, 45).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          'assets/images/image4.png',
          fit: BoxFit.cover,
          width: double.infinity,
        )),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(children: [
        CarouselSlider(
          items: item,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1.0,
              initialPage: 2,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        Positioned(
          right: 140,
          bottom: 10,
          child: DotsIndicator(
            dotsCount: item.length,
            position: currentIndex.toDouble(),
          ),
        ),
      ]),
    );
  }
}
