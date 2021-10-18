import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/utils/sharedPrefs.dart';

class UserModel extends ChangeNotifier {
  static String token = "";
  static String username = "";
  static String useremail = "";
  static String userContact = "";

  static String getToken() {
    try {
      token = StorageUtil.getString(UserModel.token) ?? "";
      // notifyListeners();
      return token;
    } catch (e) {
      return token;
    }
  }

  static setTokenFirstTime() {
    try {
      token = StorageUtil.getString(UserModel.token) ?? "";
      return token;
    } catch (e) {
      return token;
    }
  }

  // static setUserDetails(
  //     [String tokenD, String nameD, String emailD, String contactD]) {

  // }
}
