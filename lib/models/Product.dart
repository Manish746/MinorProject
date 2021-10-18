import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    @required this.id,
    @required this.images,
    this.colors = const [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    @required this.title,
    @required this.price,
    @required this.description,
  });
}

//
List productList = [
  Product(
      id: 1,
      images: ["assets/category/Banarasi.jpg"],
      title: "Silvera",
      price: 2234,
      description: "A Banarsi Saree !!"),
  Product(
      id: 2,
      images: ["assets/category/cotton.jpg"],
      title: "Kotton",
      price: 1299,
      description: "A Cotton Saree !!"),
  Product(
      id: 3,
      images: ["assets/category/handwoven.jpg"],
      title: "Hasth",
      price: 5999,
      description: "A Handwoven Saree !!"),
  Product(
      id: 4,
      images: ["assets/category/silk.jpg"],
      title: "Silk",
      price: 1234,
      description: "A silk Saree !!"),
];

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/Helmet.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Colored Helmet",
    price: 29.99,
    description:
        "A form of protective gear worn to protect the head. More specifically, a helmet complements the skull in protecting the human brain.",
    rating: 4.3,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 5,
    images: [
      "assets/images/shoes2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Shoes",
    price: 40.00,
    description: "A very nice shoes with attractive colors",
    rating: 4.5,
    isFavourite: false,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
