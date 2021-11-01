import 'package:dio/dio.dart';
import '../../apiConstant.dart';
import '../../models/product/single_product_model.dart';
import '../../utils/sharedPrefs.dart';
import '../../constants.dart';

class ProductDetailsController {
  final Dio _dio = Dio();

  Future _fetchProduct(String pId) async {
    print("Here Here");
    Response response;
    try {
      response = await this._dio.get(
            "${APIs.productDetails}" + "$pId/",
            options: Options(validateStatus: (status) => status <= 500),
          );
      return response;
    } catch (e) {
      print(response);
      print('Error in fetching Order : $e');
    }
    return response;
  }

  Future _fetchUserProduct(String pId) async {
    print("${APIs.productDetails}" +
        "$pId/" +
        "${StorageUtil.getString(kUserId)}");
    print("Token is : ${StorageUtil.getString(kUserToken)}");
    Response response;
    try {
      response = await this._dio.get(
            "${APIs.productDetails}" +
                "$pId/" +
                "${StorageUtil.getString(kUserId)}".trim(),
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

  Future<SingleProductModel> getProductDetails(String pId) async {
    Response response = await (StorageUtil.getString(kUserToken).isNotEmpty
        ? _fetchUserProduct(pId)
        : _fetchProduct(pId));
    print("response: $response + ${response.statusCode}");
    if (response == null) throw Exception("Kindly Check Internet Connection!!");
    if (response.statusCode == 200) {
      return SingleProductModel.fromJson(response.data);
    } else {
      throw Exception("Products Can't be fetched!!");
    }
  }
}
