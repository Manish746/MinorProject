import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'Cart_Local_Model.g.dart';

@HiveType(typeId: 1)
class LocalCartModel {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  int numOfItem;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final int limit;
  @HiveField(5)
  final String pName;

  LocalCartModel({
    @required this.price,
    @required this.imageUrl,
    this.limit = 10,
    @required this.pName,
    @required this.productId,
    @required this.numOfItem,
  });
}
