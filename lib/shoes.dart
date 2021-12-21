import 'package:flutter/material.dart';

class Shoes {
  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final Color color;

  Shoes({
    required this.model,
    required this.oldPrice,
    required this.currentPrice,
    required this.images,
    required this.modelNumber,
    required this.color,
  });
}

final shoes = <Shoes>[
  Shoes(
    model: 'AIR MAX 90 EZ Black',
    oldPrice: 299,
    currentPrice: 149,
    images: [
      'images/shoes1_1.png',
      'images/shoes1_2.png',
      'images/shoes1_3.png',
    ],
    modelNumber: 90,
    color: Color(0xfff6f6f6),
  ),
  Shoes(
    model: 'AIR MAX 95 RED',
    oldPrice: 399,
    currentPrice: 249,
    images: [
      'images/shoes2_1.png',
      'images/shoes2_2.png',
      'images/shoes2_3.png',
    ],
    modelNumber: 68,
    color: Color(0xfffcf5eb),
  ),
  Shoes(
    model: 'AIR MAX 270 GOLD',
    oldPrice: 489,
    currentPrice: 389,
    images: [
      'images/shoes3_1.png',
      'images/shoes3_2.png',
      'images/shoes3_3.png',
    ],
    modelNumber: 80,
    color: Color(0xfffeefef),
  ),
  Shoes(
    model: 'AIR MAX 98 FREE',
    oldPrice: 299,
    currentPrice: 149,
    images: [
      'images/shoes4_1.png',
      'images/shoes4_2.png',
      'images/shoes4_3.png',
    ],
    modelNumber: 70,
    color: Color(0xffedf3fe),
  ),
];
