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
      decoration: BoxDecoration(color: Colors.amber),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.blue),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.green),
    ),
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
          right: 160,
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
