import 'package:flutter/material.dart';

class IceCream {
  final String image, flavor;
  final double price;
  final Color lightColor, darkColor;
  double rating;
  int count;

  IceCream({
    required this.image,
    required this.flavor,
    required this.rating,
    required this.price,
    required this.lightColor,
    required this.darkColor,
    required this.count,
  });
}

final IceCreamList = [
  IceCream(
    image: "strawberry.png",
    flavor: "Strawberry",
    rating: 4.3,
    price: 50.5,
    lightColor: const Color.fromARGB(255, 255, 217, 227),
    darkColor: Colors.pink,
    count: 1,
  ),
  IceCream(
    image: "chocolate.png",
    flavor: "Chocolate",
    rating: 4.5,
    price: 60.8,
    lightColor: Colors.brown.shade300,
    darkColor: Colors.brown,
    count: 1,
  ),
];
