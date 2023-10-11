// carousel_slider.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

class CarouselSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.asset('assets/images/1.png'),
        Image.asset('assets/images/2.png'),
        Image.asset('assets/images/3.png'),
      ],
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
    );
  }
}
