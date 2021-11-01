import 'package:dio/dio.dart';
import 'package:zarees/apiConstant.dart';
import '../utils/sharedPrefs.dart';

import '../constants.dart';

class AddToWishListController {
  final Dio _dio = Dio();

  Future _addToWishList(data) async {
    Response response;
    try {
      response = await this._dio.post(
            APIs.user +
                "${StorageUtil.getString(kUserId)}" +
                "/wishlist/addtolist",
            data: data,
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
      print('Error in adding to WishList : $e');
    }
    return response;
  }

  //Future<ProductCategoryModel> getProductList(String api) async {
  Future<bool> addToWishList(data) async {
    Response response = await _addToWishList(data);
    print("response: $response");
    if (response == null) throw Exception("Kindly Check Internet Connection!!");
    if (response.statusCode == 200) {
      // if (response.data['isAdded']) {
      //   return "True";
      // } else {
      //   return "False";
      // }
      return true;
    } else {
      return false;
      //throw Exception("Products Can't be fetched!!");
    }
  }

  Future _getWishList() async {
    Response response;
    try {
      response = await this._dio.get(
            APIs.user + "${StorageUtil.getString(kUserId)}" + "/wishlist/list",
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
      print('Error in adding to WishList : $e');
    }
    return response;
  }

  Future getWishList() async {
    Response response = await _getWishList();
    print("response: $response");
    if (response == null) throw Exception("Kindly Check Internet Connection!!");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return "Not Done";
      //throw Exception("Products Can't be fetched!!");
    }
  }

  static Map<String, dynamic> toJson(String pId) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = pId;
    return data;
  }
}
