import 'package:dio/dio.dart';
import '../../models/product/product_list_model.dart';

import '../../utils/sharedPrefs.dart';

import '../../constants.dart';

class ProductListController {
  final Dio _dio = Dio();
  var productList = [];

  Future _fetchProductList(String api) async {
    Response response;
    try {
      response = await this._dio.get(
            api,
            options: Options(
              validateStatus: (status) => status <= 500,
              headers: {
                "Authorization": "bearer ${StorageUtil.getString(kUserToken)}"
              },
            ),
          );
      return response;
    } catch (e) {
      print(response);
      print('Error in fetching Order : $e');
    }
    return response;
  }

  //Future<ProductCategoryModel> getProductList(String api) async {
  Future<ProductListModel> getProductList(String api) async {
    Response response = await _fetchProductList(api);
    print("response: $response");
    if (response == null) throw Exception("Kindly Check Internet Connection!!");
    if (response.statusCode == 200) {
      //return ProductCategoryModel.fromJson(response.data);
      return ProductListModel.fromJson(response.data);
    } else {
      throw Exception("Products Can't be fetched!!");
    }
  }
}
