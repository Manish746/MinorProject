import 'package:dio/dio.dart';
import 'dart:convert';

import '../apiConstant.dart';

class OtpGenerateAndVerify {
  static Dio dio = Dio();
  static Future<Response> otpGenerate({
    String json,
    String errorText,
  }) async {
    Response response;
    try {
      response = await dio.post(
        APIs.generateOtp,
        data: json,
        options: Options(validateStatus: (status) => status <= 500),
      );
      return response;
    } catch (e) {
      print('Error in $errorText : $e');
    }
    return response;
  }

  static String toJsonOtp({var email, var otp}) {
    try {
      var temp;
      otp != null
          ? temp = {
              "email": email,
              "otp": otp,
            }
          : temp = {
              "email": email,
            };
      String json = jsonEncode(temp);
      return json;
    } catch (e) {
      print("Error in Otp toJson : $e");
    }
    return "";
  }

  static Future<Response> otpVerify({
    String json,
    String errorText,
  }) async {
    Response response;
    try {
      response = await dio.post(
        APIs.verifyOtp,
        data: json,
        options: Options(validateStatus: (status) => status <= 500),
      );
      return response;
    } catch (e) {
      print('Error in $errorText : $e');
    }
    return response;
  }
}
