import 'dart:convert';

import 'package:dio/dio.dart';

import '../apiConstant.dart';

class SignUpData {
  String name, contactNumber, email, password;

  SignUpData({this.name, this.contactNumber, this.password, this.email});

  Future<String> sendData() async {
    String data = toJson();
    String response = await _sendData(data);
    return response;
  }

  String toJson() {
    final data = jsonEncode({
      'email': this.email,
      'password': this.password,
      'fullname': this.name,
      'contact': this.contactNumber
    });
    print(data);
    return data;
  }

  static Future<String> _sendData(String data) async {
    Response response;
    try {
      final Dio dio = Dio();
      response = await dio.post(
        APIs.signup,
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
        print('All went good... user registered');
        return 'OK';
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
}
