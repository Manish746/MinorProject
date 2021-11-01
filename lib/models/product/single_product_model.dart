import './product_model.dart';

class SingleProductModel {
  SingleProductModel({
    this.product,
    this.isfavourite,
    this.inCart,
  });

  ProductModel product;
  bool isfavourite, inCart;

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json["product"]);
    isfavourite = json["isfavourite"];
    inCart = json["productInCart"];
  }
}
