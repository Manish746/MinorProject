class ProductModel {
  ProductModel({
    this.id,
    this.productName,
    this.category,
    this.price,
    this.size,
    this.description,
    this.productImage,
    this.limit = 5,
  });

  String id;
  String productName;
  String category;
  int price, limit;
  Sizes size;
  String description;
  List<dynamic> productImage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        productName: json["productName"],
        category: json["category"],
        price: json["price"],
        size: sizeValues.map[json["size"]],
        description: json["description"],
        limit: json["limit"],
        productImage: List<String>.from(json["productImage"].map((x) => x)),
      );
}

enum Sizes { S, M, L }

final sizeValues = EnumValues({"L": Sizes.L, "M": Sizes.M, "S": Sizes.S});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
