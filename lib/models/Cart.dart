import 'package:flutter/material.dart';

import './Product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({@required this.product, @required this.numOfItem});
}

List<Cart> demoCarts = [
  Cart(product: productList[0], numOfItem: 2),
  Cart(product: productList[1], numOfItem: 1),
  Cart(product: productList[3], numOfItem: 1),
];
