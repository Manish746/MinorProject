import './product_model.dart';

class ProductListModel {
  ProductListModel({
    this.count,
    this.productList,
  });

  int count;
  List<ProductModel> productList;

  ProductListModel.fromJson(Map<String, dynamic> json) {
    count = json["count"];
    productList = List<ProductModel>.from(
        json["productList"].map((x) => ProductModel.fromJson(x)));
  }
}
