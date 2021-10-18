import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/models/Cart_Local_Model.dart';

class LocalCartController extends ChangeNotifier {
  final Box<LocalCartModel> cartBox = Hive.box<LocalCartModel>(localCartBox);

  //Todo -- Local Cart Management
  addProductToCart(LocalCartModel data) {}

  addItem(String pId) {}

  removeItem(String pId) {}
}
