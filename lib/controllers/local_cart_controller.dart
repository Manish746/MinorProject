import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/models/Cart_Local_Model.dart';
import 'package:zarees/models/product/single_product_model.dart';

class LocalCartController extends ChangeNotifier {
  final Box<LocalCartModel> cartBox = Hive.box<LocalCartModel>(localCartBox);

  int _sumTotal = 0;
  //Todo -- Local Cart Management

  int get sumTotal => _sumTotal;

  LocalCartModel localCart(key) {
    return cartBox.get(key);
  }

  int get cartLength => cartBox.length ?? 0;

  _calSumTotal() {
    _sumTotal = 0;
    cartBox.values.forEach((element) {
      _sumTotal += element.numOfItem * element.price;
    });
    notifyListeners();
  }

  incrementItem(var key) {
    LocalCartModel _temp = cartBox.get(key);
    if (_temp.numOfItem < _temp.limit) {
      _temp.numOfItem += 1;
      cartBox.put(key, _temp);
    }
    _calSumTotal();
    notifyListeners();
  }

  decrementItem(var key) {
    LocalCartModel _temp = cartBox.get(key);
    if (_temp.numOfItem > 1) {
      _temp.numOfItem -= 1;
      cartBox.put(key, _temp);
    }
    _calSumTotal();
    notifyListeners();
  }

  addProductToCart(
      {@required SingleProductModel product, List<String> imageUrls}) {
    LocalCartModel _cartItem = LocalCartModel(
      price: product.product.price,
      imageUrl: (product.product.productImage.isNotEmpty)
          ? (product.product.productImage[0])
          : imageUrls[0],
      pName: product.product.productName,
      productId: product.product.id,
      numOfItem: 1,
      limit: product.product.limit,
    );
    cartBox.put(product.product.id, _cartItem);
    _calSumTotal();
    notifyListeners();
  }

  bool inCart(String pId) {
    return cartBox.get(pId) != null;
  }

  removeItem(var key) {
    cartBox.delete(key);
    _calSumTotal();
    notifyListeners();
  }
}
