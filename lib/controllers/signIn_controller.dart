import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flybuy/utils/sharedPrefs.dart';

import '../apiConstant.dart';
import '../constants.dart';

class SignInData {
  String email, password;

  SignInData({this.email, this.password});

  Future<String> sendData() async {
    String data = toJson();
    String response = await _sendData(data);
    return response;
  }

  String toJson() {
    final data = jsonEncode({
      'email': this.email,
      'password': this.password,
    });
    return data;
  }

  static Future<String> _sendData(String data) async {
    Response response;
    try {
      final Dio dio = Dio();
      response = await dio.post(
        APIs.login,
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
        data: data,
      );
      if (response.statusCode == 422) {
        print('User already exists. Please login!!!');
        return response.data['message'];
      } else if (response.statusCode == 200) {
        print('All went good... user login');
        print(
            'userid: ${response.data['userInfo']['userId']}\ntoken: ${response.data['token']}');
        if (response.data['emailVerified']) {
          print("In email");
          await setValueInSharedPref(response.data);
          print("value is " + StorageUtil.getString(kUserToken));
          return 'OK';
        } else {
          print("Not Verified");
          return "Not Verified";
        }
      } else {
        print(
            'Message from server ${response.data} with status code ${response.statusCode}');
        return response.data['message'];
      }
    } catch (err) {
      print('Error on dio initialization $err');
      return 'Something went wrong';
    }
  }

  static Future<void> setValueInSharedPref(responseData) async {
    StorageUtil.setString(kUserToken, responseData['token']);
    StorageUtil.setString(kUserId, responseData['userInfo']['userId']);
    StorageUtil.setString(kUserName, responseData['userInfo']['fullname']);
    StorageUtil.setString(kUserEmail, responseData['userInfo']['email']);
    StorageUtil.setString(kUserContact, responseData['userInfo']['contact']);
  }
}
